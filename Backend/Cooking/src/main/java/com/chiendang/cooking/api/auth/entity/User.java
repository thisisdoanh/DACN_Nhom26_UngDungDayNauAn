package com.chiendang.cooking.api.auth.entity;

import com.chiendang.cooking.api.recipe.entity.AbstractEntity;
import com.chiendang.cooking.api.recipe.entity.Recipe;
import com.chiendang.cooking.api.review.entiy.Review;
import jakarta.persistence.*;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "tbl_user")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class User extends AbstractEntity {

    @Id
    @Column(name="user_id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_seq")
    @SequenceGenerator(name = "user_seq", sequenceName = "user_seq", allocationSize = 1)
    Integer id;

    @Column(name = "email")
    String email;

    @Column(name = "password")
    String password;

    @Column(name = "dob")
    Date dob;

    @OneToMany(mappedBy = "user")
    Set<Review> reviews;

    @OneToMany(mappedBy = "user")
    Set<Recipe>  recipe;

    @ManyToMany
    @JoinTable(name = "user_role",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_name"))
    Set<Role> roles;

}
