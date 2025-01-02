package com.chiendang.cooking.service;



import com.chiendang.cooking.dto.response.ImageResponse;
import com.chiendang.cooking.entity.Image;
import com.chiendang.cooking.utils.ImageType;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ImageService {
    Image createUserImage(MultipartFile file, Integer id , ImageType imageType) throws IOException;
    List<ImageResponse> findAllImageByIdAndType(Integer id, ImageType imageType);
    void deleteUserImage(Long id) throws IOException;
}
