package com.chiendang.cooking.controller;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.ResponseError;
import com.chiendang.cooking.dto.request.ReviewRequest;
import com.chiendang.cooking.dto.request.UpdateReviewRequest;
import com.chiendang.cooking.dto.response.ReviewResponse;
import com.chiendang.cooking.entity.review.ReviewId;
import com.chiendang.cooking.service.impl.ReviewService;
import com.chiendang.cooking.exception.AppExceptions;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/review")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ReviewController {
    ReviewService reviewService;

    @PostMapping
    public ResponseData<ReviewResponse> createNewReview(@RequestBody ReviewRequest request) {
        try {

            return new ResponseData<>(HttpStatus.CREATED.value(), "", reviewService.createNewComment(request));
        } catch (AppExceptions e) {
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        } catch (Exception e) {
            log.error("An unexpected error occurred while adding review:", e);
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }
//
//    @PutMapping("/{userId}/{recipeId}")
//    public ResponseData<ReviewResponse> updateReview(@PathVariable Integer userId,
//                                                     @PathVariable Integer recipeId ,
//                                                     @RequestBody ReviewRequest request){
//        try{
//            return new ResponseData<>(HttpStatus.ACCEPTED.value(), "",reviewService.updateReview(new ReviewId(userId,recipeId),request));
//        }catch (AppExceptions e){
//            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
//        }
//    }
//
    @GetMapping("/{recipeId}")
    public ResponseData<?> getAllReviewByRecipeId(@PathVariable Integer recipeId){
        try{
            return new ResponseData<>(HttpStatus.ACCEPTED.value(), "Lấy hết các comment của món ăn",reviewService.getAllReviewByRecipeId(recipeId));
        }catch (AppExceptions e){
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }
    @PutMapping
    public ResponseData<?> updateReview(@RequestBody UpdateReviewRequest request){
        try{
            return new ResponseData<>(HttpStatus.ACCEPTED.value(), "Update comment thành công",reviewService.updateComment(request));
        }catch (AppExceptions e){
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }

    @DeleteMapping("/{userId}/{recipeId}/{commentIndex}")
    public ResponseData<?> deleteReview(@PathVariable Integer userId,
                                        @PathVariable Integer recipeId,
                                        @PathVariable String commentIndex){
        try{
            reviewService.deleteReview(new ReviewId(userId,recipeId,commentIndex));
            return new ResponseData<>(HttpStatus.ACCEPTED.value(), "Xóa comment thành công");
        }catch (AppExceptions e){
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }





}
