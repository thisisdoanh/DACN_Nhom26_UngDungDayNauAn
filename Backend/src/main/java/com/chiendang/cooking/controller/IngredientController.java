package com.chiendang.cooking.controller;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.ResponseError;
import com.chiendang.cooking.service.IngredientService;
import com.chiendang.cooking.service.impl.IngredientServiceImpl;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/ingredients")
public class IngredientController {
    private final IngredientService ingredientService;

    public IngredientController(IngredientServiceImpl ingredientService) {
        this.ingredientService = ingredientService;
    }

    @GetMapping("/{recipeId}")
    public ResponseData<?> findAllIngredientByRecipeId (@PathVariable int recipeId){
        try {
            return  new ResponseData<>(HttpStatus.OK.value(),"Get ingredient by recipe id"+ recipeId, ingredientService.findAllIngredientByRecipeId(recipeId));
        }catch (Exception e){
            return  new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }


    }
}
