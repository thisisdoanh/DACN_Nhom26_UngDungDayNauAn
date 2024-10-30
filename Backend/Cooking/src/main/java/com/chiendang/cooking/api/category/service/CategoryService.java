package com.chiendang.cooking.api.category.service;

import com.chiendang.cooking.api.category.dto.CategoryRequest;
import com.chiendang.cooking.api.category.dto.CategoryResponse;
import com.chiendang.cooking.api.category.entity.Category;
import com.chiendang.cooking.api.category.repository.CategoryRepository;
import com.chiendang.cooking.api.recipe.entity.Recipe;
import com.chiendang.cooking.api.recipe.mapper.RecipeMapper;
import com.chiendang.cooking.api.recipe.dto.request.RecipeRequest;

import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CategoryService {

    CategoryRepository categoryRepository;
    RecipeMapper recipeMapper;

    public CategoryResponse addCategory(CategoryRequest request){
        List<Recipe> recipes = recipeMapper.toRecipeList(request.getRecipe());


        Category category = new Category(request.getId(),
                request.getName(),
                recipes);

        categoryRepository.save(category);

        return CategoryResponse.builder()
                .id(category.getId())
                .name(category.getName())
                .recipe(recipeMapper.toRecipeResponseList(recipes))
                .build();
    }

    public CategoryResponse updateCategory(Integer id, CategoryRequest request){
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));

        List<Recipe> recipes = recipeMapper.toRecipeList(request.getRecipe());

        Category categoryUpdate = new Category(
                category.getId(),
                category.getName(),
                recipes
        );

        categoryRepository.save(categoryUpdate);

        return CategoryResponse.builder()
                .id(categoryUpdate.getId())
                .name(category.getName())
                .recipe(recipeMapper.toRecipeResponseList(recipes))
                .build();

    }

    public void deleteCategory(Integer categoryId){
        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));

        categoryRepository.delete(category);
    }



}
