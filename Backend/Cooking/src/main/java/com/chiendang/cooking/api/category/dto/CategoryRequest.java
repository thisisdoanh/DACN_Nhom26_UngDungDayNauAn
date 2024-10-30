package com.chiendang.cooking.api.category.dto;

import com.chiendang.cooking.api.recipe.dto.request.RecipeRequest;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CategoryRequest {

    String name;
    List<RecipeRequest> recipe;
}
