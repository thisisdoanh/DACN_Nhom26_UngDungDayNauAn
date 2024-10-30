package com.chiendang.cooking.api.instruction.entity;

import com.chiendang.cooking.api.recipe.entity.Recipe;
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
    @GeneratedValue( generator = "instruction_seq")
    @SequenceGenerator(name = "instruction_seq", sequenceName = "instruction_seq", allocationSize = 1)
    Integer id;

    @Column(name = "step_number")
    Integer stepNumber;

    @Column(name = "description")
    String description;

    @ManyToOne
    @JoinColumn(name = "recipe_id")
    Recipe recipeId;
}
