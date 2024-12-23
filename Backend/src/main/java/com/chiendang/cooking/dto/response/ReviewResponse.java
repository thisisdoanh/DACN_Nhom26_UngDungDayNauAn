package com.chiendang.cooking.dto.response;

import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ReviewResponse implements Serializable {

    UserResponse user;

    Integer recipeId;

    String commentIndex;

    String comment;

    Integer rating;
}
