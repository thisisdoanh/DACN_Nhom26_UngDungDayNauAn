package com.chiendang.cooking.api.auth.service.impl;


import com.chiendang.cooking.api.auth.dto.request.UserCreationRequest;
import com.chiendang.cooking.api.auth.dto.request.UserUpdateRequest;
import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.auth.mapper.UserMapper;
import com.chiendang.cooking.api.auth.repository.RoleRespository;
import com.chiendang.cooking.api.auth.repository.UserRespository;
import com.chiendang.cooking.api.auth.service.UserService;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.utils.Role;
import com.chiendang.cooking.exception.ErrorCode;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Optional;


@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class UserServiceImpl implements UserService {

     UserRespository userRespository;
     RoleRespository roleRespository;
     UserMapper userMapper;
     PasswordEncoder passwordEncoder;

    @Override
    public UserResponse createUser(UserCreationRequest request) {
        if(userRespository.existsByEmail(request.getEmail())){
            throw  new AppExceptions(ErrorCode.USER_EXISTED);
        }
        User user = userMapper.toUser(request);
        user.setPassword(passwordEncoder.encode(request.getPassword()));

        var roles = roleRespository.findAllById(request.getRoles());
        user.setRoles(new HashSet<>(roles));

        return userMapper.toUserResponse(userRespository.save(user));
    }
    @Override
    public  UserResponse getMyInfo(){
        var context = SecurityContextHolder.getContext();
        String name= context.getAuthentication().getName();

        User user = userRespository.findByEmail(name)
                .orElseThrow(() -> new AppExceptions(ErrorCode.USER_NOT_EXISTED));
        return userMapper.toUserResponse(user);
    }

    @Override
    // @PreAuthorize : tao ra 1 Aop bọc bên ngoài method, kieem tra quyền trc mới chạy method
    @PreAuthorize("hasRole('ADMIN')") // hasRole match vs cái nào có prefix là role
    //PreAuthorize("hasAuthority('UPDATE_DATA'))  : match vs cái nào == UPDATE_DATA
    public Page<UserResponse> getUsers(Pageable pageable){
        return userRespository.findAll(pageable).map(userMapper::toUserResponse);
    }

    @Override
    @PostAuthorize("returnObject.email == authentication.name") // chạy method trước mới kiểm tra quyền
    public Optional<User> getUser(String email) {
       return  userRespository.findByEmail(email);
    }

    @Override
    public Optional<User> getUserById(Integer id) {
        return userRespository.findById(id);
    }

    @Override
    public UserResponse updateUser(Integer id, UserUpdateRequest request) {
        Optional<User> userOptional = userRespository.findById(id);
        // Trong trường hợp Optional có 2 trường hợp nên phải có if else
        if (userOptional.isPresent()) {
            User userToUpdate = userOptional.get();  // Access the User object

            userMapper.updateUser(userToUpdate,request);
            userToUpdate.setPassword(passwordEncoder.encode(request.getPassword())); // ma hoa mk

            var roles = roleRespository.findAllById(request.getRoles());
            userToUpdate.setRoles(new HashSet<>(roles));

            return userMapper.toUserResponse(userRespository.save(userToUpdate));
        } else {
            throw  new AppExceptions(ErrorCode.USER_NOT_EXISTED);
        }

    }

    @Override
    public void deleteUser(Integer id) {
       userRespository.deleteById(id);
    }

}

