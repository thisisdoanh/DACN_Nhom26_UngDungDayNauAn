package com.chiendang.cooking.api.review.dto;

import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import com.chiendang.cooking.api.recipe.dto.response.RecipeResponse;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ReviewResponse {

    private Integer userId;

    private Integer recipeId;

    String comment;

    Integer rating;
}
