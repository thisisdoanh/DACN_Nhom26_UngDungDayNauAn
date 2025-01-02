package com.chiendang.cooking.service;

import com.chiendang.cooking.utils.PageResponse;
import com.chiendang.cooking.dto.response.RecipeResponse;

import java.util.List;

public interface RecipeService {
    List<RecipeResponse> getAllRecipeApproved();

    PageResponse<?> findRecipeByLimit(String name, long lastId, int limit);

    List<RecipeResponse> getPendingRecipes();

    void rejectRecipe(Integer recipeId);

     void approveRecipe(Integer recipeId);
}
