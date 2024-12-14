package com.chiendang.cooking.controller;


import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.ResponseError;
import com.chiendang.cooking.service.ImageService;
import com.chiendang.cooking.utils.ImageType;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Slf4j
@RestController
@RequestMapping("/api/v1/image")
@Tag(name = " Image Controller")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ImageController {
    ImageService imageService;

    @PostMapping(value = " ",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseData<?> createUserImage(@RequestParam(value = "file") MultipartFile file,
                                           @RequestParam(value = "userId",required = false) Integer userId,
                                           @RequestParam(value = "recipeId",required = false) Integer recipeId) throws IOException {

        if (file == null || file.isEmpty()) {
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), "File không được để trống");
        }

        // Trường hợp cả userId và recipeId đều null
        if (userId == null && recipeId == null) {
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), "Cần cung cấp userId hoặc recipeId");
        }

        if (userId != null && recipeId != null) {
            return new ResponseError(HttpStatus.BAD_REQUEST.value(), "Chỉ được cung cấp userId hoặc recipeId, không phải cả hai");
        }

        if (userId != null) {
            return new ResponseData<>(HttpStatus.CREATED.value(), "Thêm ảnh user thành công",
                    imageService.createUserImage(file, userId, ImageType.USER));
        }

        return new ResponseData<>(HttpStatus.CREATED.value(), "Thêm ảnh recipe thành công",
                imageService.createUserImage(file, recipeId, ImageType.RECIPE));
    }


}
