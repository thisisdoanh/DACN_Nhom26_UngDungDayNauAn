package com.chiendang.cooking.api.ingredient.dto;

import com.chiendang.cooking.api.recipe.dto.request.RecipeRequest;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class IngredientRequest {
    Integer id;

    String name;

    String amount;

    RecipeRequest recipe;
}
