package com.chiendang.cooking.api.auth.entity;

import com.chiendang.cooking.entity.favorite_recipe.FavoriteRecipe;
import com.chiendang.cooking.entity.ForgotPassword;
import com.chiendang.cooking.entity.AbstractEntity;
import com.chiendang.cooking.entity.Recipe;
import com.chiendang.cooking.entity.review.Review;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.*;

@Entity
@Table(name = "user")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class User extends AbstractEntity {

    @Id
    @Column(name="user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(name = "email")
    String email;

    @Column(name = "password")
    String password;

    @Column(name = "first_name")
    String firstName;

    @Column(name = "last_name")
    String lastName;

    @Column(name = "dob")
    Date dob;

    @OneToMany(mappedBy = "userCreated")
    @JsonIgnore
    Set<Recipe>  recipeCreatedBy;

    @OneToOne(mappedBy = "user")
    @JsonIgnore
    ForgotPassword forgotPassword;

    @OneToMany(mappedBy = "user")
    @JsonIgnore
    List<Review> reviews = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    @JsonIgnore
    Set<FavoriteRecipe> recipeFavorite = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "user_role",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_name"))
    Set<Role> roles;

    public User(String email, String firstName, String lastName) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
    }
}
