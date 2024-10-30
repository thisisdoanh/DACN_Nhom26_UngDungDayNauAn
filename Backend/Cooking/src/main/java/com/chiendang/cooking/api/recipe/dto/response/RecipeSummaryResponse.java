package com.chiendang.cooking.api.recipe.dto.response;

import com.chiendang.cooking.api.ingredient.dto.IngredientResponse;
import com.chiendang.cooking.api.instruction.dto.InstructionResponse;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class RecipeSummaryResponse {

    String recipeName;

    String prepTime;

    String cookTime;

    List<IngredientResponse> ingredients;

    List<InstructionResponse> instructions;

    String categoryName;

    String email;

    String image;

    String imageUrl;
}
