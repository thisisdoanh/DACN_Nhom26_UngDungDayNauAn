package com.chiendang.cooking.api.auth.service.impl;


import com.chiendang.cooking.api.auth.dto.request.AuthenticationRequest;
import com.chiendang.cooking.api.auth.dto.request.IntrospectRequest;
import com.chiendang.cooking.api.auth.dto.request.LogoutRequest;
import com.chiendang.cooking.api.auth.dto.request.RefreshRequest;
import com.chiendang.cooking.api.auth.dto.response.AuthenticationResponse;
import com.chiendang.cooking.api.auth.dto.response.IntrospectResponse;
import com.chiendang.cooking.api.auth.entity.InvalidatedToken;
import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.auth.repository.InvalidatedTokenRepository;
import com.chiendang.cooking.api.auth.repository.UserRespository;
import com.chiendang.cooking.api.auth.service.AutheticationService;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.text.ParseException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.StringJoiner;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class AutheticationServiceImpl implements AutheticationService {


    @NonFinal // k inject vào contructor
    @Value("${jwt.signerKey}")
    protected  String SIGNER_KEY;

    @NonFinal
    @Value("${jwt.valid-duration}")
    protected  long VALID_DURATION;

    @NonFinal
    @Value("${jwt.refreshable-duration}")
    protected  long REFRESH_DURATION;

    UserRespository userRespository;
    InvalidatedTokenRepository invalidatedTokenRepository;
    PasswordEncoder passwordEncoder;

    // kiem tra token con hieu luc khong
    @Override
    public IntrospectResponse introspect  (IntrospectRequest request)
            throws JOSEException, ParseException {
        var token = request.getToken();
        boolean isValid = true;
        try {
            verifyToken(token,false);
        }catch (AppExceptions e){
            isValid = false;
        }

        return IntrospectResponse.builder()
                .valid(isValid)
                .build();
    }

    @Override
    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        var user = userRespository.findByEmail(request.getEmail())
                .orElseThrow(() -> new AppExceptions(ErrorCode.USER_NOT_EXISTED));

        //match password request vs password user

        boolean authenticated = passwordEncoder.matches(request.getPassword(), user.getPassword());
    if (!authenticated ){
        throw  new AppExceptions(ErrorCode.UNAUTHENTICATED);
    }
    var  token = generateToken(user);

    return AuthenticationResponse.builder()
            .token(token)
            .authenticated(true)
            .build();
    }
    //logout
    @Override
    public void logout(LogoutRequest request) throws ParseException, JOSEException {
        var signToken = verifyToken(request.getToken(), true);

        String jit = signToken.getJWTClaimsSet().getJWTID();
        Date expiryTime = signToken.getJWTClaimsSet().getExpirationTime();

        InvalidatedToken invalidatedToken = InvalidatedToken.builder()
                .id(jit)
                .expiryTime(expiryTime)
                .build();

        invalidatedTokenRepository.save(invalidatedToken);
    }
    @Override
    public AuthenticationResponse refreshToken (RefreshRequest request) throws ParseException, JOSEException {
        var signJwt = verifyToken(request.getToken(), true);

        var jit = signJwt.getJWTClaimsSet().getJWTID();
        var expiryTime = signJwt.getJWTClaimsSet().getExpirationTime();

        InvalidatedToken invalidatedToken = InvalidatedToken.builder()
                .id(jit)
                .expiryTime(expiryTime)
                .build();

        invalidatedTokenRepository.save(invalidatedToken);

        var username = signJwt.getJWTClaimsSet().getSubject();

        var user = userRespository.findByEmail(username)
                .orElseThrow(() -> new AppExceptions(ErrorCode.USER_NOT_EXISTED));

        var  token = generateToken(user);

        return AuthenticationResponse.builder()
                .token(token)
                .authenticated(true)
                .build();
    }

    // tra ve thong tin token
                                                            // tham so nay dung để xác định xem expiryTime dùng cho phương thức nào
    private  SignedJWT verifyToken (String token, boolean isRefresh) throws JOSEException, ParseException {
        JWSVerifier verifier = new MACVerifier(SIGNER_KEY.getBytes());

        SignedJWT signedJWT = SignedJWT.parse(token);

        Date expiryTime = (isRefresh)
                ? new Date (signedJWT.getJWTClaimsSet().getIssueTime() // neu là refresh thì sẽ có thời gian = thời gian issue + Refresh_duration
                    .toInstant().plus(REFRESH_DURATION, ChronoUnit.SECONDS).toEpochMilli())
                : signedJWT.getJWTClaimsSet().getExpirationTime();

        var verified =  signedJWT.verify(verifier); // kiem tra chu ki

        if (!(verified && expiryTime.after(new Date()))) // chu ki k dung hoac het han
            throw new AppExceptions(ErrorCode.UNAUTHENTICATED);

        if(invalidatedTokenRepository
                .existsById(signedJWT.getJWTClaimsSet().getJWTID())) // kiem tra xem co ton tai id cua token nay trong bang k
            throw  new AppExceptions(ErrorCode.UNAUTHENTICATED);

        return signedJWT;
    }

    //tạo token
    private  String generateToken(User user){
        JWSHeader header = new JWSHeader(JWSAlgorithm.HS512);

        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .subject(user.getEmail())
                .issuer("com.chien.cooking")// token được issuer từ ai (thường là domain trang web)
                .issueTime(new Date())
                .expirationTime(new Date(
                        Instant.now().plus(VALID_DURATION, ChronoUnit.SECONDS).toEpochMilli()
                )) // xác định thời hạn tồn tại của nó
                .jwtID(UUID.randomUUID().toString())// tao cho no 1 ID
                .claim("scope", buildScope(user)) // in ra các role va permission
                .build();

        Payload payload = new Payload(jwtClaimsSet.toJSONObject());

        // cần 2 tham số là header và payload
        JWSObject jwsObject = new JWSObject(header,payload);

        // Ký token
        try {
            jwsObject.sign(new MACSigner(SIGNER_KEY.getBytes()));
            return  jwsObject.serialize();
        } catch (JOSEException e) {
            log.error("Cannot create token", e);
            throw new RuntimeException(e);
        }
    }
    // Hàm xây dựng thuộc tính token
    private String buildScope(User user){
        StringJoiner stringJoiner = new StringJoiner(" ");

        if(!CollectionUtils.isEmpty(user.getRoles())){
            user.getRoles().forEach(role -> {
                stringJoiner.add("ROLE_" +role.getName());
                if(!CollectionUtils.isEmpty(role.getPermissions())){
                    role.getPermissions().forEach(permission -> {
                        stringJoiner.add(permission.getName());
                    });
                }
            });
        }
        return  stringJoiner.toString();
    }
}
