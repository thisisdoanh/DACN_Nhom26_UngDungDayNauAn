package com.chiendang.cooking.entity.review;

import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.entity.Recipe;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Review  {

    @EmbeddedId
    ReviewId id;

    @Column(name = "comment_content")
    String comment;

    @Column(name = "rating")
    Integer rating;

    @ManyToOne
    @MapsId("userId")
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private User user;

    @ManyToOne
    @MapsId("recipeId")
    @JoinColumn(name = "recipe_id", insertable = false, updatable = false)
    private Recipe recipe;


}

