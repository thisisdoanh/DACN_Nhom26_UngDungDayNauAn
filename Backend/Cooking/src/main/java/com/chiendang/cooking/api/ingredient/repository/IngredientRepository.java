package com.chiendang.cooking.api.ingredient.repository;

import com.chiendang.cooking.api.ingredient.entity.Ingredient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface IngredientRepository extends JpaRepository<Ingredient, Integer> {
    boolean existsByName(String name);

   // @Query(value = "Select * from Ingredient i where i.name like %:= name %",nativeQuery = true)
    Ingredient findByNameContaining(String name);
}
