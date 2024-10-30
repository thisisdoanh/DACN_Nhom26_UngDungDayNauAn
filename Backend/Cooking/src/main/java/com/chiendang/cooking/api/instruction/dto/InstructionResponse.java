package com.chiendang.cooking.api.instruction.dto;

import com.chiendang.cooking.api.recipe.dto.response.RecipeResponse;
import com.chiendang.cooking.api.recipe.entity.Recipe;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InstructionResponse {
    Integer id;

    Integer stepNumber;

    String description;

    RecipeResponse recipeId;
}
 