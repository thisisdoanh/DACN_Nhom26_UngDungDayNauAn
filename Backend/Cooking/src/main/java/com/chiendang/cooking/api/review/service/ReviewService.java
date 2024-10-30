package com.chiendang.cooking.api.review.service;

import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.auth.service.UserService;
import com.chiendang.cooking.api.recipe.dto.response.RecipeResponse;
import com.chiendang.cooking.api.recipe.service.RecipeService;
import com.chiendang.cooking.api.review.dto.ReviewRequest;
import com.chiendang.cooking.api.review.dto.ReviewResponse;
import com.chiendang.cooking.api.review.entiy.Review;
import com.chiendang.cooking.api.review.entiy.ReviewId;
import com.chiendang.cooking.api.review.repository.ReviewRepository;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE , makeFinal = true)
 public class ReviewService {
    ReviewRepository reviewRepository;
    RecipeService recipeService;
    UserService userService;



    public ReviewResponse addReview(ReviewRequest request){
        User user = userService.getUserById(request.getUserId())
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));

        RecipeResponse recipeResponse = recipeService.getRecipe(request.getRecipeId());

        ReviewId id = new ReviewId(request.getUserId(),request.getRecipeId());

        Review review = new Review(
                id,
                request.getComment(),
                request.getRating()
        );

        reviewRepository.save(review);

        return ReviewResponse.builder()
                .userId(id.getUserId())
                .recipeId(id.getRecipeId())
                .rating(review.getRating())
                .comment(review.getComment())
                .build();
    }

    public ReviewResponse updateReview(ReviewId id, ReviewRequest request){
        Review review =reviewRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));


        Review reviewUpdate = new Review(
                review.getId(),
                request.getComment(),
                request.getRating()
        );

        reviewRepository.save(reviewUpdate);

        return ReviewResponse.builder()
                .userId(id.getUserId())
                .recipeId(id.getRecipeId())
                .rating(review.getRating())
                .comment(review.getComment())
                .build();
    }

    public void deleteReview (ReviewId id){
        Review  review =reviewRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));
        reviewRepository.delete(review);
    }


}
