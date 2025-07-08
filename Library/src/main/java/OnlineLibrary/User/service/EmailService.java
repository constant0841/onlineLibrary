package OnlineLibrary.User.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    // 6자리 랜덤 인증번호 생성
    public String generateVerificationCode() {
        return String.valueOf((int)(Math.random() * 900000) + 100000);
    }

    // 인증번호 이메일 전송
    public void sendVerificationEmail(String toEmail, String verificationCode) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(toEmail);
            message.setSubject("온라인 도서관 회원가입 인증번호");
            message.setText("인증번호: " + verificationCode + "\n5분 내에 입력해주세요.");

            mailSender.send(message);
        } catch (Exception e) {
            throw new RuntimeException("이메일 전송 실패", e);
        }
    }
}
