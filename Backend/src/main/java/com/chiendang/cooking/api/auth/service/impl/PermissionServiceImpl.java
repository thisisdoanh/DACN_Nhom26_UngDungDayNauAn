package com.chiendang.cooking.api.auth.service.impl;


import com.chiendang.cooking.api.auth.dto.request.PermissionRequest;
import com.chiendang.cooking.api.auth.dto.response.PermissionResponse;
import com.chiendang.cooking.api.auth.entity.Permission;
import com.chiendang.cooking.api.auth.mapper.PermissionMapper;
import com.chiendang.cooking.api.auth.repository.PermissionRespository;
import com.chiendang.cooking.api.auth.service.PermissionService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PermissionServiceImpl implements PermissionService {

    PermissionRespository permissionRespository;
    PermissionMapper permissionMapper;

     public PermissionResponse create(PermissionRequest object){
            Permission permission = permissionMapper.toPermission(object);

            permission= permissionRespository.save(permission);

            return permissionMapper.toPermissionResponse(permission);
    }

    public List<PermissionResponse> getAll(){
        var permission = permissionRespository.findAll();
        return permission.stream().map(permissionMapper::toPermissionResponse).toList();
    }

    public void  delete (String permission){
        permissionRespository.deleteById(permission);
    }
}
