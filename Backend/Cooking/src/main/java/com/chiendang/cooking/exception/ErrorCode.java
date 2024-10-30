package com.chiendang.cooking.exception;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
@Getter
public enum ErrorCode {
    FILE_EMPTY (1001,"File is empty", HttpStatus.BAD_REQUEST),
    RESOURCES_NOT_FOUND(1002, "Movie is not found", HttpStatus.NOT_FOUND),
    FILE_IS_EXISTED(1003, "File is existed", HttpStatus.BAD_REQUEST),
    PASSWORD_INVALID(1011,"Password at least 8 character", HttpStatus.BAD_REQUEST),
    USERNAME_INVALID(1016,"Username invalid", HttpStatus.BAD_REQUEST),
    UNAUTHENTICATED(1012,"Unauthenticated",HttpStatus.UNAUTHORIZED),
    UNAUTHORIZED (1013,"You do not have permission",HttpStatus.FORBIDDEN),
    USER_EXISTED(1014,"User existed",HttpStatus.FORBIDDEN),
    USER_NOT_EXISTED(1015,"User not existed",HttpStatus.FORBIDDEN)

    ;
    int  code;
    String message;
    HttpStatusCode statusCode;
}