package com.chiendang.cooking.api.ingredient.entity;

import com.chiendang.cooking.api.recipe.entity.Recipe;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "ingredient")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Ingredient {

    @Id
    @GeneratedValue( generator = "ingredient_seq")
    @SequenceGenerator(name = "ingredient_seq", sequenceName = "ingredient_seq", allocationSize = 1)
    @Column(name = "ingredient_id")
    Integer id;

    @Column(name = "ingredient_name")
    String name;

    @Column(name = "amount")
    String amount;

    @ManyToOne
    @JoinColumn(name = "recipe_id")
    Recipe recipe;
}
