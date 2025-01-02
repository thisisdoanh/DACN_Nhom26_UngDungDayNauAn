package com.chiendang.cooking.api.auth.service;


import com.chiendang.cooking.api.auth.dto.request.AuthenticationRequest;
import com.chiendang.cooking.api.auth.dto.request.IntrospectRequest;
import com.chiendang.cooking.api.auth.dto.request.LogoutRequest;
import com.chiendang.cooking.api.auth.dto.request.RefreshRequest;
import com.chiendang.cooking.api.auth.dto.response.AuthenticationResponse;
import com.chiendang.cooking.api.auth.dto.response.IntrospectResponse;
import com.nimbusds.jose.JOSEException;

import java.text.ParseException;

public interface AutheticationService  {
    AuthenticationResponse authenticate(AuthenticationRequest request);
    IntrospectResponse introspect  (IntrospectRequest request) throws JOSEException , ParseException;
    void  logout(LogoutRequest request) throws ParseException, JOSEException;
     AuthenticationResponse refreshToken (RefreshRequest request) throws ParseException, JOSEException;
}
