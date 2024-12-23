package com.chiendang.cooking.repository;

import com.chiendang.cooking.entity.favorite_recipe.FavoriteRecipe;
import com.chiendang.cooking.entity.favorite_recipe.FavoriteRecipeId;
import com.chiendang.cooking.entity.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavoriteRecipeRepository extends JpaRepository<FavoriteRecipe, FavoriteRecipeId> {
    // Lấy danh sách món ăn yêu thích của một người dùng
    List<FavoriteRecipe> findByUserIdAndIsFavoriteTrue(Integer userId);

    // Lấy tất cả món ăn yêu thích của người dùng, chỉ với các trường cần thiết (Recipe)
    @Query("SELECT fr.recipe FROM FavoriteRecipe fr WHERE fr.user.id = :userId AND fr.isFavorite = TRUE")
    List<Recipe> findFavoriteRecipesByUserId(@Param("userId") Integer userId);
}
