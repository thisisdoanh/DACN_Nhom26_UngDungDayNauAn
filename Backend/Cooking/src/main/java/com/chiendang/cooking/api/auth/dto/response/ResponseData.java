package com.chiendang.cooking.api.auth.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
public class ResponseData<T>
{
    int status;
    String message;
    T data;

     public ResponseData(int status, String message){
         this.status= status;
         this.message=message;
     }
}
