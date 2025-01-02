package com.chiendang.cooking.mapper;

import com.chiendang.cooking.dto.request.CategoryRequest;
import com.chiendang.cooking.dto.response.CategoryResponse;
import com.chiendang.cooking.entity.Category;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CategoryMapper {

    @Mapping(target = "recipe", ignore = true)
    Category toCategory(CategoryRequest request);

    CategoryResponse toCategoryResponse(Category category);

}
