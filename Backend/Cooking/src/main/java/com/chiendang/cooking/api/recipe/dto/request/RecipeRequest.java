package com.chiendang.cooking.api.recipe.dto.request;

import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.category.entity.Category;
import com.chiendang.cooking.api.ingredient.dto.IngredientRequest;
import com.chiendang.cooking.api.ingredient.dto.IngredientResponse;
import com.chiendang.cooking.api.ingredient.entity.Ingredient;
import com.chiendang.cooking.api.instruction.dto.InstructionRequest;
import com.chiendang.cooking.api.instruction.dto.InstructionResponse;
import com.chiendang.cooking.api.instruction.entity.Instruction;
import com.chiendang.cooking.api.review.entiy.Review;
import jakarta.validation.constraints.NotBlank;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class RecipeRequest {

    @NotBlank(message = "NOT_BLANK")
    String recipeName;

    String prepTime;

    String cookTime;

    List<IngredientRequest> ingredients;

    List<InstructionRequest> instructions;

    Category category;


    @NotBlank(message = "NOT_BLANK")
    String image;

    @NotBlank(message = "NOT_BLANK")
    String imageUrl;

}
