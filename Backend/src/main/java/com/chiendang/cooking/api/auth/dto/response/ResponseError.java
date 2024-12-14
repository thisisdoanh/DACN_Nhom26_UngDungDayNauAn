package com.chiendang.cooking.api.auth.dto.response;

public class ResponseError extends  ResponseData{
    public ResponseError(int status, String message) {
        super(status, message);
    }
}
