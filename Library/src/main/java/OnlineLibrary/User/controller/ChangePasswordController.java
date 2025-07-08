package OnlineLibrary.User.controller;

import OnlineLibrary.User.Repository.UserRepository;
import OnlineLibrary.User.entity.UserEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
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

    @Autowired
    private PasswordEncoder passwordEncoder;

    // 비밀번호 찾기 폼 (사용자 정보 입력)
    @GetMapping("/forgotPassword")
    public String showForgotPassword(){
        return "user/forgotPassword";
    }

    // 사용자 정보 확인 후 인증번호 전송
    @PostMapping("/forgotPassword")
    public String sendResetCode(@RequestParam String userName,
                                @RequestParam String userEmail,
                                @RequestParam String userPhone,
                                HttpSession session, Model model){
        try {
            // 전화번호에서 하이픈 제거
            String cleanPhone = userPhone.replace("-", "");
            System.out.println("하이픈 제거된 전화번호: [" + cleanPhone + "]");

            // 대소문자 무시하고 검색
            Optional<UserEntity> userOpt = userRepository.findByUserEmailAndUserNameAndUserPhoneIgnoreCase(
                    userEmail, userName, cleanPhone);

            System.out.println("DB 조회 결과: " + (userOpt.isPresent() ? "찾음" : "못찾음"));

            if(!userOpt.isPresent()){
                model.addAttribute("errorMsg", "입력하신 정보와 일치하는 계정이 없습니다.");
                return "user/forgotPassword";
            }

            // 6자리 랜덤 인증번호 생성
            String resetCode = String.valueOf((int)(Math.random() * 900000) + 100000);

            // 세션에 저장
            session.setAttribute("resetCode", resetCode);
            session.setAttribute("resetEmail", userEmail.toLowerCase()); // 소문자로 저장
            session.setMaxInactiveInterval(300); // 5분

            // 이메일 전송
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("zzzzz0830@gmail.com");
            message.setTo(userEmail);
            message.setSubject("비밀번호 재설정 인증번호");
            message.setText("비밀번호 재설정을 위한 인증번호입니다:\n\n" + resetCode + "\n\n5분 내에 입력해주세요.");

            mailSender.send(message);

            model.addAttribute("successMsg", "인증번호가 이메일로 전송되었습니다.");
            return "user/newPassword";

        } catch (Exception e){
            e.printStackTrace();
            model.addAttribute("errorMsg", "인증번호 전송 중 오류가 발생하였습니다.");
            return "user/forgotPassword";
        }
    }

    // 인증번호 입력 폼 보여주기
    @GetMapping("/newPassword")
    public String showNewPassword(HttpSession session, Model model){
        String resetCode = (String) session.getAttribute("resetCode");

        if(resetCode == null){
            model.addAttribute("errorMsg", "잘못된 접근입니다. 비밀번호 찾기를 다시 진행해주세요.");
            return "redirect:/forgotPassword";
        }
        return "user/newPassword";
    }

    // 비밀번호 변경 처리
    @PostMapping("/newPassword")
    public String changePassword(@RequestParam String resetCode,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmNewPassword,
                                 HttpSession session, Model model){
        try {
            String sessionResetCode = (String) session.getAttribute("resetCode");
            String resetEmail = (String) session.getAttribute("resetEmail");

            // 세션 확인
            if(sessionResetCode == null || resetEmail == null){
                model.addAttribute("errorMsg", "인증 시간이 만료되었습니다.");
                return "user/newPassword";
            }

            // 인증번호 확인
            if(!sessionResetCode.equals(resetCode)){
                model.addAttribute("errorMsg", "인증번호가 일치하지 않습니다.");
                return "user/newPassword";
            }

            // 비밀번호 확인
            if(!newPassword.equals(confirmNewPassword)) {
                model.addAttribute("errorMsg", "새 비밀번호가 일치하지 않습니다.");
                return "user/newPassword";
            }

            // 비밀번호 길이 확인
            if (newPassword.length() < 8) {
                model.addAttribute("errorMsg", "비밀번호는 8자 이상이어야 합니다.");
                return "user/newPassword";
            }

            // 사용자 찾기 (대소문자 무시)
            Optional<UserEntity> userOpt = userRepository.findByUserEmailIgnoreCase(resetEmail);

            if (!userOpt.isPresent()) {
                model.addAttribute("errorMsg", "사용자를 찾을 수 없습니다.");
                return "user/newPassword";
            }

            // 비밀번호 업데이트
            UserEntity user = userOpt.get();
            String encodedNewPassword = passwordEncoder.encode(newPassword);
            user.setUserPassword(encodedNewPassword);
            userRepository.save(user);

            // 세션 정리
            session.removeAttribute("resetCode");
            session.removeAttribute("resetEmail");

            return "redirect:/login?resetSuccess=true";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "비밀번호 변경 중 오류가 발생했습니다.");
            return "user/newPassword";
        }
    }
}