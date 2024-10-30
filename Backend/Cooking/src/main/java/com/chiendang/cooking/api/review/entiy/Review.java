package com.chiendang.cooking.api.review.entiy;

import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.recipe.entity.AbstractEntity;
import com.chiendang.cooking.api.recipe.entity.Recipe;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;

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
    @MapsId("userId") // Map the userId part of the embedded ID
    @JoinColumn(name = "user_id",referencedColumnName = "user_id",foreignKey = @ForeignKey(name = "FK_user_id", value = ConstraintMode.CONSTRAINT))
    User user;

    @ManyToOne
    @MapsId("recipeId") // Map the recipeId part of the embedded ID
    @JoinColumn(name = "recipe_id",referencedColumnName = "recipe_id",foreignKey = @ForeignKey(name = "FK_recipe_id", value = ConstraintMode.CONSTRAINT))
    Recipe recipe;

    public Review(ReviewId id, String comment,Integer rating){
        this.id = id;
        this.rating=rating;
        this.comment=comment;
    }


}

