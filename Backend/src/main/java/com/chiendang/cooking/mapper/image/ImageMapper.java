package com.chiendang.cooking.mapper.image;


import com.chiendang.cooking.dto.response.ImageResponse;
import com.chiendang.cooking.entity.Image;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ImageMapper {
    ImageResponse toUserImageResponse(Image userImage);
}
