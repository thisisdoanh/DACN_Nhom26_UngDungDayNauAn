package com.chiendang.cooking.api.ingredient.service;

import com.chiendang.cooking.api.ingredient.dto.IngredientRequest;
import com.chiendang.cooking.api.ingredient.dto.IngredientResponse;
import com.chiendang.cooking.api.ingredient.entity.Ingredient;
import com.chiendang.cooking.api.ingredient.repository.IngredientRepository;
import com.chiendang.cooking.api.recipe.entity.Recipe;
import com.chiendang.cooking.api.recipe.mapper.RecipeMapper;
import com.chiendang.cooking.api.recipe.respository.RecipeRepository;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class IngredientService {
    IngredientRepository ingredientRepository;
    RecipeRepository recipeRepository;
    RecipeMapper recipeMapper;


    public IngredientResponse addIngredient(IngredientRequest request){
        Recipe recipe = recipeRepository.findById(request.getId())
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));


        Ingredient ingredient = new Ingredient(
                request.getId(),
                request.getName(),
                request.getAmount(),
                recipe
        );

        ingredientRepository.save(ingredient);

        return IngredientResponse.builder()
                .id(ingredient.getId())
                .name(ingredient.getName())
                .amount(ingredient.getAmount())
                .recipe(recipeMapper.toRecipeResponse(ingredient.getRecipe()))
                .build();
    }

    public IngredientResponse updateIngredient(Integer id,IngredientRequest request){
        Recipe recipe = recipeRepository.findById(request.getId())
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));

        Ingredient ingredient = ingredientRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));

        Ingredient ingredientUpdate = new Ingredient(
                request.getId(),
                request.getName(),
                request.getAmount(),
                recipe
        );

        ingredientRepository.save(ingredientUpdate);

        return IngredientResponse.builder()
                .id(ingredientUpdate.getId())
                .name(ingredientUpdate.getName())
                .amount(ingredientUpdate.getAmount())
                .recipe(recipeMapper.toRecipeResponse(ingredientUpdate.getRecipe()))
                .build();
    }

    public void deleteIngredient(Integer id){
        Ingredient ingredient = ingredientRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));
        ingredientRepository.delete(ingredient);
    }

    public boolean existByName(String name){
        return ingredientRepository.existsByName(name);
    }

    public IngredientResponse findByName(String name){
        Ingredient ingredient = ingredientRepository.findByNameContaining(name);
        return IngredientResponse.builder()
                .id(ingredient.getId())
                .amount(ingredient.getAmount())
                .name(ingredient.getName())
                .recipe(recipeMapper.toRecipeResponse(ingredient.getRecipe()))
                .build();
    }


}
