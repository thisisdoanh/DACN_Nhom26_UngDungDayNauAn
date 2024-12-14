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
    RESOURCES_NOT_FOUND(1002, "Resource not found", HttpStatus.NOT_FOUND),
    FILE_IS_EXISTED(1003, "File is existed", HttpStatus.BAD_REQUEST),
    PASSWORD_INVALID(1011,"Password at least 8 character", HttpStatus.BAD_REQUEST),
    USERNAME_INVALID(1016,"Username invalid", HttpStatus.BAD_REQUEST),
    UNAUTHENTICATED(1012,"Unauthenticated",HttpStatus.UNAUTHORIZED),
    USER_EXISTED(1014,"User existed",HttpStatus.FORBIDDEN),
    USER_NOT_EXISTED(1015,"User not existed",HttpStatus.FORBIDDEN),
    CATEGORY_IS_EXISTED(1017, "Category is existed", HttpStatus.BAD_REQUEST),
    LIST_EMPTY(1018, "List is empty", HttpStatus.BAD_REQUEST),
    EMAIL_INVALID(1010,"Please provide valid email",HttpStatus.BAD_REQUEST),
    REVIEW_NOT_FOUND(1019,"Bình luận không tồn tại",HttpStatus.BAD_REQUEST)
    ;
    int  code;
    String message;
    HttpStatusCode statusCode;
}