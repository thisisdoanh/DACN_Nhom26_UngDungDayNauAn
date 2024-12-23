package com.chiendang.cooking.dto.request;

import com.chiendang.cooking.entity.Category;
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
    Set<IngredientRequest> ingredients;
    List<InstructionRequest> instructions;
    Category category;
    Double rating;

}
