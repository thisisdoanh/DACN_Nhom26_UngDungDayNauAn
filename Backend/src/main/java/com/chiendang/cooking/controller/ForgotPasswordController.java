package com.chiendang.cooking.controller;

import com.chiendang.cooking.api.auth.dto.response.ResponseData;
import com.chiendang.cooking.api.auth.dto.response.ResponseError;
import com.chiendang.cooking.api.auth.entity.User;
import com.chiendang.cooking.api.auth.repository.UserRespository;
import com.chiendang.cooking.entity.ForgotPassword;
import com.chiendang.cooking.utils.ChangePassword;
import com.chiendang.cooking.utils.MailBody;
import com.chiendang.cooking.repository.ForgotPasswordRepository;
import com.chiendang.cooking.service.EmailService;
import com.chiendang.cooking.exception.AppExceptions;
import com.chiendang.cooking.exception.ErrorCode;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.Date;
import java.util.Objects;
import java.util.Random;

@RestController
@RequestMapping("/forgot-password")
public class ForgotPasswordController   {

    private  final UserRespository userRespository;
    private  final EmailService emailService;
    private  final ForgotPasswordRepository forgotPasswordRepository;
    private final PasswordEncoder passwordEncoder;

    public ForgotPasswordController(UserRespository userRespository, EmailService emailService, ForgotPasswordRepository forgotPasswordRepository, PasswordEncoder passwordEncoder) {
        this.userRespository = userRespository;
        this.emailService = emailService;
        this.forgotPasswordRepository = forgotPasswordRepository;
        this.passwordEncoder = passwordEncoder;
    }


    // send email for email verification
    @PostMapping("/verify-mail/{email}")
    public ResponseData<String> verifyEmail(@PathVariable String email){
        User user = userRespository.findByEmail(email)
                .orElseThrow(() -> new AppExceptions(ErrorCode.EMAIL_INVALID));

        int otp = otpGenerator();
        MailBody mailBody = MailBody.builder()
                .to(email)
                .text("This is the OTP for your Forgot Password request:" + otp)
                .subject("OTP for Forgot Password")
                .build();

        ForgotPassword fp = ForgotPassword.builder()
                .otp(otp)
                .expirationTime(new Date(System.currentTimeMillis()+70 *1000))
                .user(user)
                .build();

        emailService.sendSimpleMessage(mailBody);
        forgotPasswordRepository.save(fp);

        return  new ResponseData<>(HttpStatus.OK.value(),"Email send for verification");
    }

    @PostMapping("/verify-otp/{email}/{otp}")
    public ResponseData<String> verifyOtp(@PathVariable String email, @PathVariable  Integer otp){
        User user = userRespository.findByEmail(email)
                .orElseThrow(() -> new AppExceptions(ErrorCode.EMAIL_INVALID));

        ForgotPassword forgotPassword = forgotPasswordRepository.findByOtpAndUser(otp,user)
                .orElseThrow(()-> new RuntimeException("Invalid OTP for email: "  + email));

        //kiem tra het han chua
        if (forgotPassword.getExpirationTime().before(Date.from(Instant.now()))){
            forgotPasswordRepository.deleteById(forgotPassword.getFpid());
            return new ResponseError(HttpStatus.EXPECTATION_FAILED.value(), "OTP has expired");
        }
        return new ResponseData<>(HttpStatus.OK.value(), "OTP verified!");
    }

    //charge password
    @PostMapping("/change-password/{email}")
    public  ResponseData<String> changePasswordHandler (@RequestBody ChangePassword changePassword,
                                                        @PathVariable String email){
        if(!Objects.equals(changePassword.password(),changePassword.repeatPassword())){
            return  new ResponseError(HttpStatus.EXPECTATION_FAILED.value(), "Please enter the password again");
        }

        String encodedPassword = passwordEncoder.encode(changePassword.password());
        userRespository.updatePassword(email,encodedPassword);
        return new ResponseData<>(HttpStatus.OK.value(), "Password has been changed !");
    }

    private Integer otpGenerator() {
        Random random = new Random();
        return random.nextInt(100_000,999_999);
    }
}
