package com.chiendang.cooking.service;


import com.chiendang.cooking.utils.MailBody;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Value("${spring.mail.from}")
    private  String fromEmailId;

    private final JavaMailSender javaMailSender;

    public EmailService(JavaMailSender javaMailSender){
        this.javaMailSender = javaMailSender;
    }




    public  void sendSimpleMessage (MailBody mailBody){
        SimpleMailMessage message  = new SimpleMailMessage();

        message.setTo(mailBody.to());
        message.setFrom(fromEmailId); // lay username
        message.setSubject(mailBody.subject());
        message.setText(mailBody.text());

        javaMailSender.send(message);
    }
}
