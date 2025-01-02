package com.chiendang.cooking.api.auth.dto.request;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserUpdateRequest {

    String password;
    LocalDate dob;
    List<String> roles;
    String firstName;
    String lastName;
    Date createdAt;
    Date updatedAt;
}
