package com.chiendang.cooking.mapper;

import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import com.chiendang.cooking.dto.response.ReviewResponse;
import com.chiendang.cooking.entity.review.Review;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ReviewMapper {

    public ReviewResponse toReviewResponse(Review review){
        return ReviewResponse.builder()
                .comment(review.getComment())
                .rating(review.getRating())
                .user((new UserResponse(review.getUser().getId(),review.getUser().getEmail(),review.getUser().getFirstName(),review.getUser().getLastName())))
                .commentIndex(review.getId().getCommentIndex())
                .recipeId(review.getId().getRecipeId())
                .build();
    }

     public List<ReviewResponse> toListReviewResponse(List<Review> reviews){
        return reviews.stream().map(this::toReviewResponse).toList();
    }
}
