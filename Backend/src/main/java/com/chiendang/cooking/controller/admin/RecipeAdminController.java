package com.chiendang.cooking.controller.admin;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.ResponseError;
import com.chiendang.cooking.dto.response.RecipeResponse;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.service.RecipeService;
import com.chiendang.cooking.utils.PageResponse;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.constraints.Min;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/api/v1/recipes")

@RequiredArgsConstructor
@Tag(name = "Manage recipe for admin")
public class RecipeAdminController {

    private final RecipeService recipeService;

    @Operation(method = "GET", summary = "Get recipe pending", description = "Send a request via this API to pending recipe")
    @GetMapping
    public ResponseData<List<RecipeResponse>> findRecipePending(){
        try {
            return new ResponseData<>(HttpStatus.OK.value(), "Lấy danh sách thành công", recipeService.getPendingRecipes() );
        }catch (AppExceptions e){
            return  new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }


    // Duyệt bài viết
    @Operation(method = "POST", summary = "Approved recipe", description = "Send a request via this API to approved recipe")
    @PostMapping("/approve/{id}")
    public ResponseData<?> approveRecipe(@PathVariable Integer id) {
        recipeService.approveRecipe(id);
        try {
            return new ResponseData<>(HttpStatus.OK.value(), "Approved recipe successful !!" );
        }catch (AppExceptions e){
            return  new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }

    // Từ chối bài viết
    @PostMapping("/reject/{id}")
    public ResponseData<?> rejectRecipe(@PathVariable Integer id) {
        recipeService.rejectRecipe(id);
        try {
            return new ResponseData<>(HttpStatus.OK.value(), "Reject recipe  !!" );
        }catch (AppExceptions e){
            return  new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }
}
