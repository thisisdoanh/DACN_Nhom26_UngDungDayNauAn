package com.chiendang.cooking.api.review.repository;

import com.chiendang.cooking.api.review.entiy.Review;
import com.chiendang.cooking.api.review.entiy.ReviewId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReviewRepository extends JpaRepository<Review, ReviewId> {
}
