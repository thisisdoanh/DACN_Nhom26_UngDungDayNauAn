package com.chiendang.cooking.api.review;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.ResponseError;
import com.chiendang.cooking.api.review.dto.ReviewRequest;
import com.chiendang.cooking.api.review.dto.ReviewResponse;
import com.chiendang.cooking.api.review.entiy.Review;
import com.chiendang.cooking.api.review.entiy.ReviewId;
import com.chiendang.cooking.api.review.service.ReviewService;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/review")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ReviewController {
    ReviewService reviewService;

    @PostMapping
    public ResponseData<ReviewResponse> addReview(@RequestBody ReviewRequest request) {
        try {

            return new ResponseData<>(HttpStatus.CREATED.value(), "", reviewService.addReview(request));
        } catch (AppExceptions e) {
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        } catch (Exception e) {
            log.error("An unexpected error occurred while adding review:", e);
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }

    @PutMapping("/{userId}/{recipeId}")
    public ResponseData<ReviewResponse> updateReview(@PathVariable Integer userId,
                                                     @PathVariable Integer recipeId ,
                                                     @RequestBody ReviewRequest request){
        try{
            return new ResponseData<>(HttpStatus.ACCEPTED.value(), "",reviewService.updateReview(new ReviewId(userId,recipeId),request));
        }catch (AppExceptions e){
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }

    @DeleteMapping("/{userId}/{recipeId}")
    public ResponseData<?> deleteReview(@PathVariable Integer userId,
                                        @PathVariable Integer recipeId){
        try{
            reviewService.deleteReview(new ReviewId(userId,recipeId));
            return new ResponseData<>(HttpStatus.ACCEPTED.value(), "");
        }catch (AppExceptions e){
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        }
    }



}
