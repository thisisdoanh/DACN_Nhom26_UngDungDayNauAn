package com.chiendang.cooking.api.recipe.mapper;


import com.chiendang.cooking.api.auth.dto.request.UserUpdateRequest;
import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.recipe.dto.request.RecipeRequest;
import com.chiendang.cooking.api.recipe.dto.response.RecipeResponse;
import com.chiendang.cooking.api.recipe.entity.Recipe;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.util.List;

@Mapper(componentModel = "spring")
public interface RecipeMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "users", ignore = true)
    @Mapping(target = "user", ignore = true)
    Recipe toRecipe(RecipeRequest request);

    @Mapping(target = "imageUrl" , ignore = true)
    RecipeResponse toRecipeResponse(Recipe recipe);

    List<Recipe> toRecipeList(List<RecipeRequest> requests);

    List<RecipeResponse> toRecipeResponseList(List<Recipe> recipes);


}
