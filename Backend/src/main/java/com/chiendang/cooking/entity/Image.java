package com.chiendang.cooking.entity;

import com.chiendang.cooking.utils.ImageType;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "image")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Image {

    @Id
    @Column(name="id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "image_seq")
    @SequenceGenerator(name = "image_seq", sequenceName = "image_seq", allocationSize = 1)
    Long id;
    String imageUrl;
    String cloudImageId;
    String imageName;

    @Enumerated(EnumType.STRING)
    ImageType imageType;
    Integer referenceId;


}
