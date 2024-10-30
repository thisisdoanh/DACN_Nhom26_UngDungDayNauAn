package com.chiendang.cooking.api.recipe.respository;

import com.chiendang.cooking.api.recipe.dto.response.RecipeResponse;
import com.chiendang.cooking.api.recipe.entity.Recipe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecipeRepository extends JpaRepository<Recipe,Integer> {

    @Query(value = " Select a.* " +
            "FROM Recipe a " +
            "INNER JOIN Category b ON a.category_id = b.id" +
            "INNER JOIN Ingredient c ON a.recipe_id = c.recipe_id" +
            "WHERE 1=1" +
            "AND a.recipe_name LIKE % :=key % " +
            "OR b.name LIKE % :=key %" +
            "OR c.name LIKE % :=key %"
            , nativeQuery = true)
    List<RecipeResponse> findAllRecipeWithKey(String key);
}
