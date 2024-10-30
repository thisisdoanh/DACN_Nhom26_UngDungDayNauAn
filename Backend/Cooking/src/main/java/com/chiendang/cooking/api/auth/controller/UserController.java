package com.chiendang.cooking.api.auth.controller;


import com.chiendang.cooking.api.auth.dto.request.UserCreationRequest;
import com.chiendang.cooking.api.auth.dto.request.UserUpdateRequest;
import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import com.chiendang.cooking.api.auth.service.UserService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class UserController {

    UserService userService;

    @PostMapping
    public ResponseData<UserResponse> createController(@RequestBody @Valid UserCreationRequest request){
        return new ResponseData<>(HttpStatus.CREATED.value(), "Used added successfully! ", userService.createUser(request));
    }

    @GetMapping
    public ResponseData<Page<UserResponse>> getUsers(final Pageable pageable){
        var authentication = SecurityContextHolder.getContext().getAuthentication(); // lay thong tin dang dang nhap vao he thong

        log.info("Username: {}",authentication.getName());
        authentication.getAuthorities().forEach(grantedAuthority -> log.info(grantedAuthority.getAuthority()));

        return new ResponseData<>(HttpStatus.OK.value(), "List users are found", userService.getUsers(pageable));
    }


    @GetMapping(path = "/{email}")
    public ResponseData<?> getUserById(@PathVariable("email") String email){
        // với kiểu giữ liệu trả về Optional có thêm orElse
        return  new ResponseData<>(HttpStatus.OK.value(), "User is found", userService.getUser(email));
    }

    @GetMapping(path = "/myInfo")
    public ResponseData<UserResponse> getMyInfo(){

        return  new ResponseData<>(HttpStatus.OK.value(), "User is found", userService.getMyInfo());
    }

    @PutMapping(path = "/{userId}")
    public ResponseData<UserResponse> updateUser (@PathVariable("userId") Integer userId,@RequestBody UserUpdateRequest request){
        return new ResponseData<>(HttpStatus.ACCEPTED.value(),"User updated successfully! ",userService.updateUser(userId,request));
    }

    @DeleteMapping(path =  "/{userId}")
    public  ResponseData<?> deleteUser (@ PathVariable("userId") Integer userId){
        userService.deleteUser(userId);
        return new ResponseData<>(HttpStatus.NO_CONTENT.value(), "User is deleted");
    }
}
