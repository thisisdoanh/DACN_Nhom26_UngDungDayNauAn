package com.chiendang.cooking.api.auth.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;

public class ResponseSuccess extends ResponseEntity<ResponseSuccess.PayLoad> {

    //PUT, PATCH, DELETE
    public ResponseSuccess(HttpStatusCode status,String message ) {
        super(new PayLoad (status.value() , message),HttpStatus.OK);
    }
    //GET, POST
    public ResponseSuccess(HttpStatusCode status,String message, Object data) {
        super(new PayLoad (status.value() , message,data),HttpStatus.OK);
    }

    @Data
    @AllArgsConstructor
    public static class PayLoad{
        final int status;
        final String message;
        Object data;
        public PayLoad(int status,String message){
            this.status =status;
            this.message= message;
        }
    }
}
