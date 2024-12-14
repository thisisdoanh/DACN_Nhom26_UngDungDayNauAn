package com.chiendang.cooking.controller;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.ResponseError;
import com.chiendang.cooking.service.impl.FavoriteRecipeService;
import com.chiendang.cooking.dto.response.RecipeResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/favorite-recipe")
@RequiredArgsConstructor
@Tag(name = "favorite-recipe")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class FavoriteRecipeController {
    FavoriteRecipeService favoriteRecipeService;

    @GetMapping("/{id}")
    public ResponseData<List<RecipeResponse>> getFavoriteRecipe(@PathVariable Integer id){
        try {
            log.info("Get favorite recipe successfully");
            return new ResponseData<>(HttpStatus.OK.value(), "Get recipe succesfully",favoriteRecipeService.getFavoriteRecipes(id));
        }catch (Exception e){
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }

    @PostMapping("/{userId}/{recipeId}/toggle")
    public ResponseData<?> toggleFavorite(@PathVariable("userId") Integer userId, @PathVariable("recipeId") Integer recipeId) {
        Boolean isFavorite = favoriteRecipeService.toggleFavorite(userId, recipeId);
        String message = isFavorite ? "Recipe has been marked as favorite." : "Recipe has been removed from favorites.";
        return new ResponseData<>(HttpStatus.CREATED.value(),message);
    }

}
