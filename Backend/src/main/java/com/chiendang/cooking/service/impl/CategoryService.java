package com.chiendang.cooking.service.impl;

import com.chiendang.cooking.dto.request.CategoryRequest;
import com.chiendang.cooking.dto.response.CategoryResponse;
import com.chiendang.cooking.entity.Category;
import com.chiendang.cooking.mapper.CategoryMapper;
import com.chiendang.cooking.repository.CategoryRepository;

import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CategoryService {

    CategoryRepository categoryRepository;
    CategoryMapper categoryMapper;

    public CategoryResponse addCategory(CategoryRequest request){
        if (categoryRepository.existsByName(request.getName())){
            throw  new AppExceptions(ErrorCode.CATEGORY_IS_EXISTED);
        }
        Category category  = categoryRepository.save(Category.builder()
                .name(request.getName()).build());

        return  CategoryResponse.builder()
                .id(category.getId())
                .name(category.getName())
                .build();
    }

    public CategoryResponse updateCategory(Integer id, CategoryRequest request){
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));

        category.setName(request.getName());

        categoryRepository.save(category);

        return CategoryResponse.builder()
                .id(category.getId())
                .name(category.getName())
                .build();

    }

    public void deleteCategory(Integer categoryId){
        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));

        categoryRepository.delete(category);
    }

    public List<CategoryResponse> findAllCategories (){
        List<Category> categories =  categoryRepository.findAll();
        return categories.stream().map(categoryMapper::toCategoryResponse).collect(Collectors.toList());
    }

    public List<CategoryResponse> findAllCategoriesByName (String name){
        List<Category> categories = categoryRepository.findByNameContainingIgnoreCase(name);
        return categories.stream().map(categoryMapper::toCategoryResponse).collect(Collectors.toList());
    }


}
