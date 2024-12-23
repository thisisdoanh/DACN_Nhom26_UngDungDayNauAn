package com.chiendang.cooking.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import java.util.List;


// cấu hình Spring Security
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    private  final  String[] PUBLIC_ENDPOINTS = {"/users/**",
            "/auth/**"

    };

    @Autowired
    private CustomJwtDecoder customJwtDecoder;

    public SecurityConfig(CustomJwtDecoder customJwtDecoder) {
        this.customJwtDecoder = customJwtDecoder;
    }

    //xác định endpoint nào cần bảo vệ endpoint nào có thể tự do truy cập
    // 2 endpoint đăng kí và xác nhận token cân đc tự do truy cập
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity.authorizeHttpRequests(request -> request.anyRequest().permitAll());
//                request
//                        .requestMatchers(HttpMethod.POST, "/forgot-password/**").permitAll()
//                        .requestMatchers(HttpMethod.POST, "/api/v1/users/**").permitAll()
//                        .requestMatchers(HttpMethod.POST, "/auth/**").permitAll()
//
//                        // Allow GET requests for Swagger and OpenAPI documentation
//                        .requestMatchers(HttpMethod.GET, "/swagger-ui*/**").permitAll()
//                        .requestMatchers(HttpMethod.GET, "/v3/**").permitAll()
//
//                        // Allow GET requests for public resources, e.g., recipes
//                        .requestMatchers(HttpMethod.GET, "/api/v1/recipes/**").permitAll()
//                        .requestMatchers(HttpMethod.GET,"/api/v1/categories/**").permitAll()
//                        .anyRequest().authenticated()); // nếu k có url nào trùng vs cái trên thì yêu cầu xác thực

        // vấn đề: khi request có một  token trong header
        // ResourceServer bắt đầu xác thực
        httpSecurity.oauth2ResourceServer(oauth2 ->
                oauth2.jwt(jwtConfigurer -> jwtConfigurer.decoder(customJwtDecoder) // giải mã jwt
                                                         .jwtAuthenticationConverter(jwtAuthenticationConverter())) //custom authority
                                                         .authenticationEntryPoint(new JwtAuthenticationEntryPoint())
                );

        // Spring Secu tự bật csrf để bảo vệ khỏi bị tấn công
        httpSecurity.csrf(AbstractHttpConfigurer::disable);
        return httpSecurity.build();
    }

    @Bean
    public CorsFilter corsFilter(){
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);
        config.setAllowedOrigins(List.of("http://localhost:5173"));
        config.setAllowedMethods(List.of("GET","POST","PUT","DELETE"));
        config.addAllowedHeader("*");
        source.registerCorsConfiguration("/**",config);

        return  new CorsFilter(source);
    }

    //custom lại authority
    @Bean
    JwtAuthenticationConverter jwtAuthenticationConverter(){
        JwtGrantedAuthoritiesConverter jwtGrantedAuthoritiesConverter = new JwtGrantedAuthoritiesConverter();
        jwtGrantedAuthoritiesConverter.setAuthorityPrefix("");

        JwtAuthenticationConverter jwtAuthenticationConverter = new JwtAuthenticationConverter();
        jwtAuthenticationConverter.setJwtGrantedAuthoritiesConverter(jwtGrantedAuthoritiesConverter);

        return jwtAuthenticationConverter;
    }



    @Bean
    PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder(10);
    }

}
