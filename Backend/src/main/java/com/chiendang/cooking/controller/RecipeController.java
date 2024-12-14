package com.chiendang.cooking.controller;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.ResponseError;
import com.chiendang.cooking.dto.request.RecipeRequest;
import com.chiendang.cooking.dto.response.RecipeResponse;
import com.chiendang.cooking.utils.PageResponse;
import com.chiendang.cooking.service.impl.RecipeServiceImpl;
import com.chiendang.cooking.exception.AppExceptions;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.Min;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/api/v1/recipes")
@RequiredArgsConstructor
@Tag(name = "recipe")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RecipeController {
    RecipeServiceImpl recipeService;

    @Operation(method = "POST", summary = "Add new user", description = "Send a request via this API to create new user")
    @PostMapping(consumes = { MediaType.MULTIPART_FORM_DATA_VALUE })
    public ResponseData<RecipeResponse> createNewRecipe(@RequestParam(name = "file") MultipartFile file,
                                                        @RequestParam(name = "request") String request,
                                                        @RequestParam(name = "userId") Integer userId) throws IOException {

        RecipeRequest recipeRequest = convertToRecipeRequest(request);
        return  new ResponseData<>(HttpStatus.CREATED.value(), "Thêm công thuc thanh cong !!", recipeService.createNewRecipe(recipeRequest,file,userId));
    }


    @Operation(method = "GET", summary = "Get recipe limit", description = "Send a request via this API to get user")
    @GetMapping
    public ResponseData<PageResponse<?>> findRecipeByLimit(@RequestParam(value = "lastId", defaultValue = "0") long lastId,
                                                           @Min(5) @RequestParam(value = "limit" , defaultValue = "10") int limit,
                                                           @RequestParam(value = "name", required = false) String recipeName){
        try {
            return new ResponseData<>(HttpStatus.OK.value(), "Lấy danh sách thành công", recipeService.findRecipeByLimit(recipeName,lastId,limit) );
        }catch (AppExceptions e){
            return  new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }

    // chuyển 1 chuỗi String sang Json
    private RecipeRequest convertToRecipeRequest(String recipeRequest) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return  objectMapper.readValue(recipeRequest, RecipeRequest.class);

    }
}
