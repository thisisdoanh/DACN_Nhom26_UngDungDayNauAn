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
public class ReviewRequest implements Serializable {

    Integer userId;

    Integer recipeId;

    String comment;

    Integer rating;


}
