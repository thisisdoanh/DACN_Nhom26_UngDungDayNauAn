package com.chiendang.cooking.api.recipe.entity;

import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.category.entity.Category;
import com.chiendang.cooking.api.ingredient.entity.Ingredient;
import com.chiendang.cooking.api.instruction.entity.Instruction;
import com.chiendang.cooking.api.review.entiy.Review;
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
    @GeneratedValue(generator = "recipe_seq")
    @SequenceGenerator(name = "recipe_seq", sequenceName = "recipe_seq", allocationSize = 1)
     Integer id;

    @Column(name = "recipe_name", nullable = false)
    String recipeName;

    @Column(name = "prep_time")
     String prepTime;

    @Column(name = "cook_time")
     String cookTime;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "recipe")
     Set<Ingredient> ingredients = new HashSet<>();

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "recipeId")
     List<Instruction> instructions = new ArrayList<>();


    @ManyToOne( fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
     Category category;

    @ManyToMany
    @JoinTable(name = "review",
            joinColumns = @JoinColumn(name = "recipe_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id"))
     Set<User> users = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;

    @Column(name = "image", nullable = false)
     String image;

    @JsonIgnore // Stop infinite loop
    public Set<Ingredient> getIngredients() {
        return ingredients;
    }

    @JsonIgnore
    public List<Instruction> getInstructions() {
        return instructions;
    }

}