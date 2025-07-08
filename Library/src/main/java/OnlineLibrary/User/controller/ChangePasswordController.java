package OnlineLibrary.User.controller;

import OnlineLibrary.User.Repository.UserRepository;
import OnlineLibrary.User.entity.UserEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class ChangePasswordController {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JavaMailSender mailSender;

    @GetMapping("/changePassword")
    public String showChangePassword(){
        return "user/changePassword";
    }

    @PostMapping("/changePassword")
    public String goChangePassword(@RequestParam String userName,
                                   @RequestParam String userEmail,
                                   @RequestParam String userPhone,
                                   HttpSession session, Model model){
        try {
            Optional<UserEntity> userOpt = userRepository.findByUserEmailAndUserNameAndUserPhone(userEmail, userName, userPhone);

            if(!userOpt.isPresent()){
                model.addAttribute("errorMsg", "입력하신 정보와 일치하는 계정이 없습니다.");
                return "user/changePassword";
            }

            String resetCode = String.valueOf((int)(Math.random() * 900000) + 100000);

            session.setAttribute("resetCode", resetCode);
            session.setAttribute("resetEmail", userEmail);
            session.setMaxInactiveInterval(300);

            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("zzzzz0830@gmail.com");
            message.setTo(userEmail);
            message.setSubject("비밀번호 재설정 인증번호");
            message.setText("비밀번호 재설정을 위한 인증번호입니다:\n\n" +
            resetCode + "\n\n5분 내에 입력해주세요.");
            mailSender.send(message);

            return "redirect:/resetPassword";
        } catch (Exception e){
            e.printStackTrace();
            model.addAttribute("errorMsg", "인증번호 전송 중 오류가 발생하였습니다.");
            return "user/changePassword";
        }

    }
}
