package com.chiendang.cooking.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "instruction")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Instruction {

    @Id
    @Column(name = "instruction_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(name = "step_number")
    Integer stepNumber;

    @Column(name = "description")
    String description;

    @ManyToOne
    @JoinColumn(name = "recipe_id")
    Recipe recipeId;


}
