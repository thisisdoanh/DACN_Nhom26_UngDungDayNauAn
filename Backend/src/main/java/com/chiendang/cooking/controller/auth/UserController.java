package com.chiendang.cooking.controller.auth;


import com.chiendang.cooking.api.auth.dto.request.UserCreationRequest;
import com.chiendang.cooking.api.auth.dto.request.UserUpdateRequest;
import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.UserResponse;
import com.chiendang.cooking.api.auth.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
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
@RequestMapping("/api/v1/users")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
@Tag(name = "User Controller")
public class   UserController {

    UserService userService;

    @Operation(method = "POST", summary = "Add new user", description = "Send a request via this API to create new user")
    @PostMapping
    public ResponseData<UserResponse> createUser(@RequestBody @Valid UserCreationRequest request){
        return new ResponseData<>(HttpStatus.CREATED.value(), "Used added successfully! ", userService.createUser(request));
    }

    @Operation(summary = "Get all user permanently", description = "Send a request via this API to get all user permanently")
    @GetMapping
    public ResponseData<Page<UserResponse>> getUsers(final Pageable pageable){
        var authentication = SecurityContextHolder.getContext().getAuthentication(); // lay thong tin dang dang nhap vao he thong

        log.info("Username: {}",authentication.getName());
        authentication.getAuthorities().forEach(grantedAuthority -> log.info(grantedAuthority.getAuthority()));

        return new ResponseData<>(HttpStatus.OK.value(), "List users are found", userService.getUsers(pageable));
    }

    @Operation(summary = "Get user permanently", description = "Send a request via this API to get user permanently")
    @GetMapping(path = "/{email}")
    public ResponseData<?> getUserById(@PathVariable("email") String email){
        // với kiểu giữ liệu trả về Optional có thêm orElse
        return  new ResponseData<>(HttpStatus.OK.value(), "User is found", userService.getUser(email));
    }
    @Operation(summary = "Get info User", description = "Send a request via this API to get ìnfo user permanently")
    @GetMapping(path = "/myInfo")
    public ResponseData<UserResponse> getMyInfo(){

        return  new ResponseData<>(HttpStatus.OK.value(), "User is found", userService.getMyInfo());
    }

    @Operation(summary = "Update user", description = "Send a request via this API to update user")
    @PutMapping(path = "/{userId}")
    public ResponseData<UserResponse> updateUser (@PathVariable("userId") Integer userId,@RequestBody UserUpdateRequest request){
        return new ResponseData<>(HttpStatus.ACCEPTED.value(),"User updated successfully! ",userService.updateUser(userId,request));
    }

    @Operation(summary = "Delete user permanently", description = "Send a request via this API to delete user permanently")
    @DeleteMapping(path =  "/{userId}")
    public  ResponseData<?> deleteUser (@ PathVariable("userId") Integer userId){
        userService.deleteUser(userId);
        return new ResponseData<>(HttpStatus.NO_CONTENT.value(), "User is deleted");
    }
}
