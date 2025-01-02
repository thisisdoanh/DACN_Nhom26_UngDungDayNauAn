package com.chiendang.cooking.repository;


import com.chiendang.cooking.entity.Image;
import com.chiendang.cooking.utils.ImageType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ImageRepository extends JpaRepository<Image,Long> {
    List<Image> findAllByReferenceId(Integer id);


    List<Image> findAllByReferenceIdAndImageType(Integer id, ImageType imageType);


    List<Image> findAllByImageType(ImageType imageType);
}
