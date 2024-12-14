package com.chiendang.cooking.repository;

import com.chiendang.cooking.entity.review.Review;
import com.chiendang.cooking.entity.review.ReviewId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, ReviewId> {
    @Query("SELECT r FROM Review r WHERE r.recipe.id = :recipeId")
    List<Review> findAllByRecipeId(@Param("recipeId") Integer recipeId);
}
