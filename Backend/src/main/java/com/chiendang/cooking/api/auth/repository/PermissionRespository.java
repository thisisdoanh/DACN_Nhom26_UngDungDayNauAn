package com.chiendang.cooking.api.auth.repository;


import com.chiendang.cooking.api.auth.entity.Permission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PermissionRespository extends JpaRepository<Permission, String> {
}
