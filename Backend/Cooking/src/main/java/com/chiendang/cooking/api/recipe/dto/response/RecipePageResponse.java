package com.chiendang.cooking.api.recipe.dto.response;

import java.util.List;

public record RecipePageResponse(List<RecipeResponse> movieResponses,
                                 Integer pageNumber,
                                 Integer pageSize,
                                 long totalElements,
                                 int totalPages,
                                 boolean inLast) {
}
