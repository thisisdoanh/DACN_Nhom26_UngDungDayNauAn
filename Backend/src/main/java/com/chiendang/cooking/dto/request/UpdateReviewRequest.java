package com.chiendang.cooking.dto.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UpdateReviewRequest implements Serializable {

    Integer userId;

    Integer recipeId;

    String commentIndex;

    String comment;

    Integer rating;


}
