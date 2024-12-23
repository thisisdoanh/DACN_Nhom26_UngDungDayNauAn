package com.chiendang.cooking.service.impl;


import com.chiendang.cooking.dto.response.CloudResponse;
import com.chiendang.cooking.dto.response.ImageResponse;
import com.chiendang.cooking.entity.Image;
import com.chiendang.cooking.mapper.image.CloudImageMapper;
import com.chiendang.cooking.mapper.image.ImageMapper;
import com.chiendang.cooking.repository.ImageRepository;
import com.chiendang.cooking.service.CloudinaryService;
import com.chiendang.cooking.service.ImageService;
import com.chiendang.cooking.utils.ImageType;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE,makeFinal = true)
public class ImageServiceImpl implements ImageService {
    ImageRepository userImageRepository;
    ImageMapper mapper;
    CloudinaryService cloudinaryService;
    CloudImageMapper cloudImageMapper;


    @Override
    public Image createUserImage(MultipartFile file, Integer id, ImageType imageType) throws IOException {
        Map<?,?> res = cloudinaryService.upload(file);

        //get original_filename
        String originalFileName = file.getOriginalFilename();
        CloudResponse cloudResponse = cloudImageMapper.toCloudResponse(res);

        return userImageRepository.save(Image.builder()
                        .cloudImageId(cloudResponse.getPublicId())
                        .imageUrl(cloudResponse.getUrl())
                        .imageName(originalFileName)
                        .referenceId(id)
                        .imageType(imageType)
                        .build());
    }

    @Override
    public List<ImageResponse> findAllImageByIdAndType(Integer userId, ImageType imageType) {
        return userImageRepository.findAllByReferenceIdAndImageType(userId,imageType).stream().map(mapper::toUserImageResponse).collect(Collectors.toList());
    }

    @Override
    public void deleteUserImage(Long id) throws IOException {
        Image userImage = userImageRepository.findById(id)
                .orElseThrow( ()-> new RuntimeException("Khong tim thay user image"));
        cloudinaryService.delete(userImage.getCloudImageId());
        userImageRepository.delete(userImage);
    }
}
