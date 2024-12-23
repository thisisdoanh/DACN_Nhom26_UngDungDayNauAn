package com.chiendang.cooking.configuration;


import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.exception.ErrorCode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import java.io.IOException;
// xu li truong hop request http  k xac thuc tra ve 1 chuoi json
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        ErrorCode errorCode = ErrorCode.UNAUTHENTICATED;

        response.setStatus(errorCode.getStatusCode().value());
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);

        ResponseData<?> responseData = ResponseData.builder()
                .status(errorCode.getCode())
                .message(errorCode.getMessage())
                .build();
        //giup chuyen giu lieu ve String
        ObjectMapper objectMapper = new ObjectMapper();

        //ghi responseData vao response
        response.getWriter().write(objectMapper.writeValueAsString(responseData));
        //commit
        response.flushBuffer();
    }
}
