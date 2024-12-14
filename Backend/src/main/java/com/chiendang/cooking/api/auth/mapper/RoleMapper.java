package com.chiendang.cooking.api.auth.mapper;


import com.chiendang.cooking.api.auth.dto.request.RoleRequest;
import com.chiendang.cooking.api.auth.dto.response.RoleResponse;
import com.chiendang.cooking.api.auth.entity.Role;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;


@Mapper(componentModel = "spring")
public interface RoleMapper {

    @Mapping(target = "permissions" , ignore = true)
    Role toRole(RoleRequest request);

    RoleResponse toRoleResponse(Role role);

}
