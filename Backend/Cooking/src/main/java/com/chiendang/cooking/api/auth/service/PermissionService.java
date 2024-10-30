package com.chiendang.cooking.api.auth.service;



import com.chiendang.cooking.api.auth.dto.request.PermissionRequest;
import com.chiendang.cooking.api.auth.dto.response.PermissionResponse;

import java.util.List;

public interface PermissionService {
    PermissionResponse create(PermissionRequest object);
    List<PermissionResponse> getAll();
    void  delete (String permission);
}
