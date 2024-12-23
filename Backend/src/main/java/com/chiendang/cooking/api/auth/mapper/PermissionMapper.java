package com.chiendang.cooking.api.auth.mapper;

import com.chiendang.cooking.api.auth.dto.request.PermissionRequest;
import com.chiendang.cooking.api.auth.dto.response.PermissionResponse;
import com.chiendang.cooking.api.auth.entity.Permission;


import org.mapstruct.Mapper;


@Mapper(componentModel = "spring")
public interface PermissionMapper {
    Permission toPermission(PermissionRequest request);
    PermissionResponse toPermissionResponse(Permission permission);

}
