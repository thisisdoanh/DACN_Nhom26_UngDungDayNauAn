package com.chiendang.cooking.api.review.dto;

import com.chiendang.cooking.api.auth.dto.request.UserCreationRequest;
import com.chiendang.cooking.api.recipe.dto.request.RecipeRequest;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ReviewRequest {

    private Integer userId;

    private Integer recipeId;

    String comment;

    Integer rating;
}
