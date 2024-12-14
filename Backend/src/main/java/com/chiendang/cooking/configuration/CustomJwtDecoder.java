package com.chiendang.cooking.configuration;


import com.chiendang.cooking.api.auth.dto.request.IntrospectRequest;
import com.chiendang.cooking.api.auth.service.AutheticationService;
import com.chiendang.cooking.api.auth.service.impl.AutheticationServiceImpl;
import com.nimbusds.jose.JOSEException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.stereotype.Component;

import javax.crypto.spec.SecretKeySpec;
import java.text.ParseException;
import java.util.Objects;

// giải mã jwt
// sử dụng introspect để token logout không thể sử dụng
// ở những đường dẫn cần authen

@Component
public class CustomJwtDecoder implements JwtDecoder{
    @Value("${jwt.signerKey}")
    private String signerKey;


    private final AutheticationService authenticationService;

    private NimbusJwtDecoder nimbusJwtDecoder = null;

    @Lazy // khởi tạo bean khi được gọi đến
    public CustomJwtDecoder(AutheticationService authenticationService) {
        this.authenticationService = authenticationService;
    }


    @Override
    public Jwt decode(String token) throws JwtException {

        try {
            var response = authenticationService.introspect(
                    IntrospectRequest.builder().token(token).build());

            if (!response.isValid()) throw new JwtException("Token invalid");
        } catch (JOSEException | ParseException e) {
            throw new JwtException(e.getMessage());
        }

        if (Objects.isNull(nimbusJwtDecoder)) {
            SecretKeySpec secretKeySpec = new SecretKeySpec(signerKey.getBytes(), "HS512");
            nimbusJwtDecoder = NimbusJwtDecoder.withSecretKey(secretKeySpec)
                    .macAlgorithm(MacAlgorithm.HS512)
                    .build();
        }

        return nimbusJwtDecoder.decode(token);
    }
}

