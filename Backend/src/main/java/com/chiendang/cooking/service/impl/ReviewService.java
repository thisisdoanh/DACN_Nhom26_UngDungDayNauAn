package com.chiendang.cooking.service.impl;

import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.auth.service.UserService;
import com.chiendang.cooking.dto.request.ReviewRequest;
import com.chiendang.cooking.dto.request.UpdateReviewRequest;
import com.chiendang.cooking.dto.response.ReviewResponse;
import com.chiendang.cooking.entity.review.Review;
import com.chiendang.cooking.entity.review.ReviewId;
import com.chiendang.cooking.entity.Recipe;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import com.chiendang.cooking.mapper.ReviewMapper;
import com.chiendang.cooking.repository.ReviewRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE , makeFinal = true)
 public class ReviewService {
    ReviewRepository reviewRepository;
    RecipeServiceImpl recipeService;
    UserService userService;
    ReviewMapper reviewMapper;


    public ReviewResponse createNewComment(ReviewRequest request) {
        // Tạo UUID cho commentIndex
        String commentIndex = UUID.randomUUID().toString();

        // Tạo khóa chính phức hợp
        ReviewId reviewId = new ReviewId();
        reviewId.setUserId(request.getUserId());
        reviewId.setRecipeId(request.getRecipeId());
        reviewId.setCommentIndex(commentIndex);

        // Tìm user và recipe nếu cần (không bắt buộc nếu chỉ cần ID)
        Optional<User> user = userService.getUserById(request.getUserId());
        if(user.isEmpty()){
            throw new AppExceptions(ErrorCode.USER_NOT_EXISTED);
        }
        Recipe recipe = recipeService.getRecipeInfo(request.getRecipeId());

        // Tạo đối tượng Review
        Review review = new Review();
        review.setId(reviewId);
        review.setComment(request.getComment());
        review.setRating(request.getRating());
        review.setUser(user.get());
        review.setRecipe(recipe);
        return reviewMapper.toReviewResponse(reviewRepository.save(review));
    }



    public ReviewResponse updateComment(UpdateReviewRequest request) {
        // Tìm đối tượng Review bằng khóa chính phức hợp
        ReviewId reviewId = new ReviewId();
        reviewId.setUserId(request.getUserId());
        reviewId.setRecipeId(request.getRecipeId());
        reviewId.setCommentIndex(request.getCommentIndex()); // Lấy từ request

        // Kiểm tra xem Review có tồn tại không
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new AppExceptions(ErrorCode.REVIEW_NOT_FOUND));

        // Cập nhật các trường cần thiết
        if (request.getComment() != null && !request.getComment().isBlank()) {
            review.setComment(request.getComment());
        }
        if (request.getRating() != null) {
            review.setRating(request.getRating());
        }

        // Lưu lại Review đã cập nhật
        Review updatedReview = reviewRepository.save(review);

        // Trả về ReviewResponse sau khi cập nhật
        return reviewMapper.toReviewResponse(updatedReview);
    }
    public void deleteReview (ReviewId id){
        Review  review =reviewRepository.findById(id)
                .orElseThrow(() -> new AppExceptions(ErrorCode.RESOURCES_NOT_FOUND));
        reviewRepository.delete(review);
    }

    public List<ReviewResponse> getAllReviewByRecipeId(Integer recipeId){
        return reviewMapper.toListReviewResponse(reviewRepository.findAllByRecipeId(recipeId));
    }


}
