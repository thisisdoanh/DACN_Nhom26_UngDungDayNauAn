package com.chiendang.cooking.repository;

import com.chiendang.cooking.entity.Ingredient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IngredientRepository extends JpaRepository<Ingredient, Integer> {
    boolean existsByName(String name);

   // @Query(value = "Select * from Ingredient i where i.name like %:= name %",nativeQuery = true)
    Ingredient findByNameContaining(String name);

    @Query(value = """
            Select * from ingredient i
            where i.recipe_id = :id
            """,nativeQuery = true)
    List<Ingredient> findAllByRecipeId(@Param("id")Integer id);
}
