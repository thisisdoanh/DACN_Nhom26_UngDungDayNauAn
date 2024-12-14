package com.chiendang.cooking.dto.response;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InstructionResponse {
    Integer id;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    Integer stepNumber;

    String description;

    @JsonIgnore
    RecipeResponse recipeId;

    public InstructionResponse(Integer id, Integer stepNumber, String description) {
        this.id = id;
        this.stepNumber = stepNumber;
        this.description = description;
    }
}
 