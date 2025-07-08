package OnlineLibrary.User.controller;

import OnlineLibrary.User.dto.InsertRegisterDTO;
import OnlineLibrary.User.service.InsertRegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
public class RegisterController {

    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    private InsertRegisterService insertRegisterService;

    @GetMapping("/register")
    public String goRegister(){
        return "user/register";
    }

    @PostMapping("/register")
    public String checkRegister(@ModelAttribute InsertRegisterDTO registerDTO,
                                HttpSession session, Model model){
        try {
            String sessionCode = (String)session.getAttribute("verificationCode");
            String sessionEmail = (String)session.getAttribute("verificationEmail");

            // registerDTO.getEmailVerifyCode() 사용
            if(sessionCode == null || !sessionCode.equals(registerDTO.getEmailVerifyCode())) {
                model.addAttribute("errorMsg", "인증번호가 일치하지 않습니다.");
                return "user/register";
            }

            if(!registerDTO.getUserEmail().equals(sessionEmail)){
                model.addAttribute("errorMsg", "인증된 이메일과 다른 이메일입니다.");
                return "user/register";
            }

            insertRegisterService.registerUser(registerDTO);

            boolean success = insertRegisterService.registerUser(registerDTO);

            if(!success){
                model.addAttribute("errorMsg", "이미 사용 중인 이메일입니다.");
                return "user/register";
            }

            session.removeAttribute("verificationCode");
            session.removeAttribute("verificationEmail");
            return "redirect:/login?success=true";

        } catch (Exception e){
            e.printStackTrace(); // 상세 에러 출력
            model.addAttribute("errorMsg", "회원가입 중 오류가 발생하였습니다: " + e.getMessage());
            return "user/register";
        }
    }

    @PostMapping("/sendEmail")
    @ResponseBody
    public String sendEmail(@RequestParam String userEmail, HttpSession session) {
        try {
            // 6자리 랜덤 인증번호 생성
            String verificationCode = String.valueOf((int)(Math.random() * 900000) + 100000);

            // 세션에 인증번호와 이메일 저장 (5분간 유효)
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("verificationEmail", userEmail);
            session.setMaxInactiveInterval(300); // 5분

            // 이메일 전송
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("zzzzz0830@gamil.com"); // 발신자 (설정한 네이버 메일)
            message.setTo(userEmail); // 수신자
            message.setSubject("온라인 도서관 회원가입 인증번호");
            message.setText("안녕하세요!\n\n회원가입 인증번호는 다음과 같습니다:\n\n" +
                    verificationCode + "\n\n5분 내에 입력해주세요.\n\n온라인 도서관 팀");

            mailSender.send(message);

            return "인증번호가 " + userEmail + "로 전송되었습니다.";

        } catch (Exception e) {
            e.printStackTrace(); // 콘솔에 에러 출력
            return "이메일 전송에 실패했습니다: " + e.getMessage();
        }
    }
}