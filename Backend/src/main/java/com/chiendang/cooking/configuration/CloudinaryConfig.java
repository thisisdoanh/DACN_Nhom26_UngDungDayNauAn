package com.chiendang.cooking.configuration;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.cloudinary.utils.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;

@Configuration
public class CloudinaryConfig {

    private final String cloudName;
    private final String apiKey;
    private final String apiSecret;

    // Constructor-based injection
    public CloudinaryConfig(
            @Value("${cloud.name}") String cloudName,
            @Value("${cloud.api-key}") String apiKey,
            @Value("${cloud.api-secret}") String apiSecret) {
        if (StringUtils.isEmpty(cloudName) || StringUtils.isEmpty(apiKey) || StringUtils.isEmpty(apiSecret)) {
            throw new IllegalArgumentException("Cloudinary credentials must not be empty");
        }
        this.cloudName = cloudName;
        this.apiKey = apiKey;
        this.apiSecret = apiSecret;
    }

    @Bean
    @Lazy
    public Cloudinary cloudinary() {
        try {
            return new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", cloudName,
                    "api_key", apiKey,
                    "api_secret", apiSecret,
                    "secure", true));
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khởi tạo cloud", e);
        }
    }
}
