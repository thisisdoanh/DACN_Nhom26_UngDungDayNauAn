package com.chiendang.cooking.api.recipe.dto.response;

import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.category.entity.Category;
import com.chiendang.cooking.api.ingredient.dto.IngredientResponse;
import com.chiendang.cooking.api.ingredient.entity.Ingredient;
import com.chiendang.cooking.api.instruction.dto.InstructionResponse;
import com.chiendang.cooking.api.instruction.entity.Instruction;
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
public class RecipeResponse {


    String recipeName;

    String prepTime;

    String cookTime;


    List<IngredientResponse> ingredients;

    List<InstructionResponse> instructions;

    Category category;

    User user;

    String image;

    String imageUrl;
}
