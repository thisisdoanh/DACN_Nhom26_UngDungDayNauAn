package com.chiendang.cooking.entity;

import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.entity.favorite_recipe.FavoriteRecipe;
import com.chiendang.cooking.entity.review.Review;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "recipe")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Recipe extends AbstractEntity {

    @Id
    @Column(name = "recipe_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
     Integer id;

    @Column(name = "recipe_name", nullable = false)
    String recipeName;

    @Column(name = "prep_time")
     String prepTime;

    @Column(name = "cook_time")
     String cookTime;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "recipe",  orphanRemoval = true)
    Set<Ingredient> ingredients = new HashSet<>();

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "recipeId",  orphanRemoval = true)
     List<Instruction> instructions = new ArrayList<>();


    @ManyToOne( fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
     Category category;

    @OneToMany(mappedBy = "recipe")
    @JsonIgnore
    List<Review> reviewers = new ArrayList<>();


    @OneToMany(mappedBy = "recipe")
    @JsonIgnore
    Set<FavoriteRecipe> userFavoriteRecipe = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "user_id")
    User userCreated;

    @Column(name = "image")
    String image;

    @Column(name = "rating")
    Double rating;


    @JsonIgnore // Stop infinite loop
    public Set<Ingredient> getIngredients() {
        return ingredients;
    }

    @JsonIgnore
    public List<Instruction> getInstructions() {
        return instructions;
    }


}