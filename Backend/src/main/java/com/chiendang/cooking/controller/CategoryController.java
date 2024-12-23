package com.chiendang.cooking.controller;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.dto.request.CategoryRequest;
import com.chiendang.cooking.dto.response.CategoryResponse;
import com.chiendang.cooking.service.impl.CategoryService;
import com.chiendang.cooking.exception.AppExceptions;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/categories")
@RequiredArgsConstructor
@Tag(name = "category")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CategoryController {
    CategoryService categoryService;

    @Operation(method = "GET", summary = "Get all category", description = "Send a request via this API to get all category by name ")
    @GetMapping()
    public ResponseData<List<CategoryResponse>> findAllCategoriesByName (@RequestParam(required = false) String name){
        if(StringUtils.hasLength(name)){
            return new ResponseData<>(HttpStatus.ACCEPTED.value(), "Get all category by name ", categoryService.findAllCategoriesByName(name));
        }
        else {
            return new ResponseData<>(HttpStatus.ACCEPTED.value(), "Get all category", categoryService.findAllCategories());
        }

    }

    @Operation(summary = "Create new category", description = "Send a request via this API to create new category")
    @PostMapping
    public ResponseData<CategoryResponse> createCategory (@RequestBody CategoryRequest request){
        try {
            return new ResponseData<>(HttpStatus.CREATED.value(), "Create new category", categoryService.addCategory(request));
        }catch (AppExceptions e){
            return  new ResponseData<>(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }

    @Operation(summary = "Update category", description = "Send a request via this API to update category")
    @PutMapping("/{categoryId}")
    public ResponseData<CategoryResponse> updateCategory (@PathVariable Integer categoryId, @RequestBody CategoryRequest request){
        try {
            return new ResponseData<>(HttpStatus.CREATED.value(), "Update category", categoryService.updateCategory(categoryId, request));
        }catch (AppExceptions e){
            return  new ResponseData<>(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }

    }

    @Operation(summary = "Delete category", description = "Send a request via this API to delete category")
    @DeleteMapping("/{categoryId}")
    public ResponseData<?> deleteCategory (@PathVariable Integer categoryId){
        try {
            categoryService.deleteCategory(categoryId);
            return new ResponseData<>(HttpStatus.CREATED.value(), "Delete category");
        }catch (AppExceptions e){
            return  new ResponseData<>(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }






}
