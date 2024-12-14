package com.chiendang.cooking.api.auth.service;

import com.chiendang.cooking.api.auth.dto.request.RoleRequest;
import com.chiendang.cooking.api.auth.dto.response.RoleResponse;

import java.util.List;

public interface RoleService {
    RoleResponse create (RoleRequest request);
    List<RoleResponse> getAll();
    void delete (String role);

}
