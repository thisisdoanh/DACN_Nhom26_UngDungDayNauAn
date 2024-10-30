package com.chiendang.cooking.exception;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.Objects;

@ControllerAdvice
public class GlobalException {


    @ExceptionHandler(value = AppExceptions.class)
    ResponseEntity<ResponseData<?>> handingAppExceptions(AppExceptions exception){
        ErrorCode errorCode = exception.getErrorCode();
        return ResponseEntity.status(errorCode.getStatusCode())
                .body(new ResponseData<>(errorCode.getCode(), errorCode.getMessage()));
    }

    @ExceptionHandler(value = AccessDeniedException.class)
    ResponseEntity<ResponseData<?>> handlingAccessDenied(AccessDeniedException exception){
        ErrorCode errorCode=ErrorCode.UNAUTHORIZED;
        return  ResponseEntity.status(errorCode.getStatusCode())
                .body(new ResponseData<>(errorCode.getCode(), errorCode.getMessage()));

    }

    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    ResponseEntity<ResponseData<?>> handingValidation (MethodArgumentNotValidException exception){
        String enumKey = Objects.requireNonNull(exception.getFieldError()).getDefaultMessage();
        ErrorCode errorCode = ErrorCode.valueOf(enumKey);
        return ResponseEntity.badRequest().body(new ResponseData<>(errorCode.getCode(),errorCode.getMessage()));
    }
}
