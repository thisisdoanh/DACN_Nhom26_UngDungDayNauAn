package com.chiendang.cooking.mapper;

import com.chiendang.cooking.dto.request.IngredientRequest;
import com.chiendang.cooking.dto.response.IngredientResponse;
import com.chiendang.cooking.entity.Ingredient;
import org.springframework.stereotype.Component;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class IngredientMapper {

    public Ingredient toIngredient(IngredientRequest request){
        if (request== null){
            return null;
        }else {
            Ingredient.IngredientBuilder ingredient = Ingredient.builder();
                    ingredient.name(request.getName());
                    ingredient.amount(request.getAmount());
            return  ingredient.build();
        }
    }

    public IngredientResponse toInIngredientResponse(Ingredient i) {
        if (i == null) {
            return null;
        } else {
            IngredientResponse.IngredientResponseBuilder ingredientResponse = IngredientResponse.builder();
            ingredientResponse.id(i.getId());
            ingredientResponse.name(i.getName());
            ingredientResponse.amount(i.getAmount());

            return ingredientResponse.build();
        }
    }

    public Set<IngredientResponse> toListIngredientResponse (Set<Ingredient> set){
        return set.stream().map(this::toInIngredientResponse).collect(Collectors.toSet());
    }

    public Set<Ingredient> toListIngredient (Set<IngredientRequest> set){
        return set.stream().map(this::toIngredient).collect(Collectors.toSet());
    }

}
