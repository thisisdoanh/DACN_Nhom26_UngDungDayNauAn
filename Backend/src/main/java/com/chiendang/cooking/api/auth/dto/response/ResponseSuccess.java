package com.chiendang.cooking.api.auth.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;

public class ResponseSuccess extends ResponseEntity<ResponseSuccess.PayLoad> {

    //PUT, PATCH, DELETE
    public ResponseSuccess(HttpStatusCode status,String message ) {
        super(new PayLoad (status.value() , message),HttpStatus.OK); // de HttpStatuc.Ok de cho phep body tra ve du lieu
    }
    //GET, POST
    public ResponseSuccess(HttpStatusCode status,String message, Object data) {
        super(new PayLoad (status.value() , message, data ) ,HttpStatus.OK);
    }


    @Getter
    public static class PayLoad{
        private final int status;
        private final String message;
        private Object data;

        public PayLoad(int status,String message){
            this.status =status;
            this.message= message;
        }

        public PayLoad(int status, String message,Object data ) {
            this.data = data;
            this.message = message;
            this.status = status;
        }

    }
}
