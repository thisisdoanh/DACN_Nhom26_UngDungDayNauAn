package com.chiendang.cooking.service.impl;

import com.chiendang.cooking.api.auth.repository.UserRespository;
import com.chiendang.cooking.entity.favorite_recipe.FavoriteRecipe;
import com.chiendang.cooking.entity.favorite_recipe.FavoriteRecipeId;
import com.chiendang.cooking.repository.FavoriteRecipeRepository;
import com.chiendang.cooking.dto.response.RecipeResponse;
import com.chiendang.cooking.entity.Recipe;
import com.chiendang.cooking.mapper.RecipeMapper;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class FavoriteRecipeService {
    FavoriteRecipeRepository favoriteRecipeRepository;
    UserRespository userRespository;
    RecipeMapper recipeMapper;

    public List<RecipeResponse> getFavoriteRecipes(Integer id) {
//        var context = SecurityContextHolder.getContext();
//        String name= context.getAuthentication().getName();

//         User user = userRespository.findByEmail(name)
//                .orElseThrow(() -> new AppExceptions(ErrorCode.USER_NOT_EXISTED));

         List<Recipe> recipes = favoriteRecipeRepository.findFavoriteRecipesByUserId(id);

         if(recipes == null || recipes.isEmpty()){
             throw new AppExceptions(ErrorCode.LIST_EMPTY);
         }

        return recipes.stream().map(recipeMapper::toRecipeResponse).toList();
    }

    public Boolean toggleFavorite(Integer userId, Integer recipeId) {
        FavoriteRecipeId favoriteRecipeId = new FavoriteRecipeId(userId,recipeId);
        Optional<FavoriteRecipe> favoriteRecipeOptional = favoriteRecipeRepository.findById(favoriteRecipeId);

        if (favoriteRecipeOptional.isPresent()) {
            FavoriteRecipe favoriteRecipe = favoriteRecipeOptional.get();
            Boolean newFavoriteStatus = !favoriteRecipe.getIsFavorite();
            favoriteRecipe.setIsFavorite(newFavoriteStatus);
            favoriteRecipeRepository.save(favoriteRecipe);
            return newFavoriteStatus;
        } else {
            FavoriteRecipe favoriteRecipe = FavoriteRecipe.builder()
                    .id(favoriteRecipeId)
                    .isFavorite(true)
                    .build();
            favoriteRecipeRepository.save(favoriteRecipe);
            return true;
        }
    }

}
