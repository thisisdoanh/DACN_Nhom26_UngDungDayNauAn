package com.chiendang.cooking.entity;

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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
