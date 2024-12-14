package com.chiendang.cooking.exception;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class ErrorResponse
{
    private Date timeStamp;
    private  int status;
    private String path;
    private  String error;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private  String message;
}
