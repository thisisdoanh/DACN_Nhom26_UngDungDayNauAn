package com.chiendang.cooking.api.auth.repository;


import com.chiendang.cooking.api.auth.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRespository extends JpaRepository<Role,String> {
}
