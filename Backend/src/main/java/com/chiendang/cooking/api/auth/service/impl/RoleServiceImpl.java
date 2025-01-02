package com.chiendang.cooking.api.auth.service.impl;


import com.chiendang.cooking.api.auth.dto.request.RoleRequest;
import com.chiendang.cooking.api.auth.dto.response.RoleResponse;
import com.chiendang.cooking.api.auth.mapper.RoleMapper;
import com.chiendang.cooking.api.auth.repository.PermissionRespository;
import com.chiendang.cooking.api.auth.repository.RoleRespository;
import com.chiendang.cooking.api.auth.service.RoleService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults( level =AccessLevel.PRIVATE, makeFinal = true)
public class RoleServiceImpl implements RoleService {
    RoleRespository roleRespository;
    PermissionRespository permissionRespository;
    RoleMapper roleMapper;

    @Override
    public RoleResponse create(RoleRequest request) {
        var role = roleMapper.toRole(request);

        var permissions = permissionRespository.findAllById(request.getPermissions());

        role.setPermissions(new HashSet<>(permissions));

        role= roleRespository.save(role);

        return roleMapper.toRoleResponse(role);
    }

    @Override
    public List<RoleResponse> getAll() {
        var roles = roleRespository.findAll();
        return roles.stream()
                .map(roleMapper::toRoleResponse)
                .toList();
    }

    @Override
    public void delete(String role) {
        roleRespository.deleteById(role);
    }


}
