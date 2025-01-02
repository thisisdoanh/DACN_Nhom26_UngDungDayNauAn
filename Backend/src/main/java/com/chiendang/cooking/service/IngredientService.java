package com.chiendang.cooking.service;

import com.chiendang.cooking.dto.request.IngredientRequest;
import com.chiendang.cooking.dto.response.IngredientResponse;

import java.util.Set;

public interface IngredientService {
    Set<IngredientResponse> addAllIngredient(Set<IngredientRequest> list);
    Set<IngredientResponse> findAllIngredientByRecipeId(Integer id);

}
