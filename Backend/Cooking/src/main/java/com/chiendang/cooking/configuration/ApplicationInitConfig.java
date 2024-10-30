package com.chiendang.cooking.configuration;


import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.auth.repository.UserRespository;
import com.chiendang.cooking.utils.Role;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.HashSet;

//mỗi khi start Application sẽ khởi tạo duy nhat 1 tài khoản user admin
@Configuration
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
@Slf4j
public class ApplicationInitConfig {

    PasswordEncoder passwordEncoder;
    //sẽ được khởi chạy mỗi khi application chạy
    @Bean
    ApplicationRunner applicationRunner(UserRespository userRespository){
        return args -> {
            if (userRespository.findByEmail("admin@gmail.com").isEmpty()){
                var roles = new HashSet<String>();
                roles.add(Role.ADMIN.name());

                User user = User.builder()
                        .email("admin@gmail.com")
                        .password(passwordEncoder.encode("admin"))
                        //.roles(roles)
                        .build();

                userRespository.save(user);
                log.warn("Admin user has been created with default password : admin ");
            }
        };
    }
}
