package com.chiendang.cooking.api.image.service;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;

@RestController
@RequestMapping("/file")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ImageController {
    ImageService imageService;

    @NonFinal
    @Value("${project.foodimage}")
    String path;

    @PostMapping("/upload")
    public ResponseData<?> uploadFileHandler(@RequestPart MultipartFile file) throws IOException {
        String uploadedFileName = imageService.uploadFile(path, file);
        return ResponseData.builder()
                .status(HttpStatus.OK.value())
                .message("File uploaded: " + uploadedFileName)
                .build();
    }

    @GetMapping("/{fileName}")
    public void serveFileHandler(@PathVariable String fileName, HttpServletResponse response) throws IOException {
        InputStream resourceFile = imageService.getResourceFile(path, fileName);
        response.setContentType(MediaType.IMAGE_PNG_VALUE);
        StreamUtils.copy(resourceFile, response.getOutputStream());
    }
}