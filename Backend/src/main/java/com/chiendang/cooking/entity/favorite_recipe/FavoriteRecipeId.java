package com.chiendang.cooking.entity.favorite_recipe;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

@Embeddable
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class FavoriteRecipeId implements Serializable {
    @Column(name = "user_id")
    private Integer userId;


    @JoinColumn(name = "recipe_id")
    private Integer recipeId;

}
