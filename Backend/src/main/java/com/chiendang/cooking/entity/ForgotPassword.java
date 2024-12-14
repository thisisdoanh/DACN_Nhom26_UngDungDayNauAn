package com.chiendang.cooking.entity;

import com.chiendang.cooking.api.auth.entity.User;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Entity
@Table(name = "forgot_password")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ForgotPassword {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer fpid;

    @Column(nullable = false)
    Integer otp;

    @Column(nullable = false)
    Date expirationTime;

    @OneToOne
    @JoinColumn( name = "user_id")
    User user;
}
