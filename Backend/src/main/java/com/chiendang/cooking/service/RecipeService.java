package com.chiendang.cooking.service;

import com.chiendang.cooking.utils.PageResponse;
import com.chiendang.cooking.dto.response.RecipeResponse;

import java.util.List;

public interface RecipeService {
    List<RecipeResponse> getAllRecipe ();
    PageResponse<?> findRecipeByLimit (String name, long lastId , int limit);
}
