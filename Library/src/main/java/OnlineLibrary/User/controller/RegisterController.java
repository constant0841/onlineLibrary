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

            System.out.println("=== 회원가입 처리 시작 ===");
            System.out.println("입력된 인증번호: " + registerDTO.getEmailVerifyCode());
            System.out.println("세션 인증번호: " + sessionCode);
            System.out.println("입력된 이메일: " + registerDTO.getUserEmail());
            System.out.println("세션 이메일: " + sessionEmail);

            // 인증번호 확인
            if(sessionCode == null || !sessionCode.equals(registerDTO.getEmailVerifyCode())) {
                model.addAttribute("errorMsg", "인증번호가 일치하지 않습니다.");
                return "user/register";
            }

            // 이메일 확인
            if(!registerDTO.getUserEmail().equals(sessionEmail)){
                model.addAttribute("errorMsg", "인증된 이메일과 다른 이메일입니다.");
                return "user/register";
            }

            // 🔧 수정: registerUser() 메서드를 한 번만 호출
            boolean success = insertRegisterService.registerUser(registerDTO);

            if(!success){
                System.out.println("회원가입 실패 - 이메일 중복 또는 기타 오류");
                model.addAttribute("errorMsg", "이미 사용 중인 이메일입니다.");
                return "user/register";
            }

            // 성공 시 세션 정리
            session.removeAttribute("verificationCode");
            session.removeAttribute("verificationEmail");

            System.out.println("회원가입 성공 - 로그인 페이지로 리다이렉트");
            return "redirect:/login?success=true";

        } catch (Exception e){
            System.err.println("회원가입 처리 중 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMsg", "회원가입 중 오류가 발생하였습니다: " + e.getMessage());
            return "user/register";
        }
    }

    @PostMapping("/sendEmail")
    @ResponseBody
    public String sendEmail(@RequestParam String userEmail, HttpSession session) {
        try {
            System.out.println("=== 이메일 인증 요청 ===");
            System.out.println("요청 이메일: " + userEmail);

            // 이메일 중복 체크 먼저 수행
            if(insertRegisterService.isEmailExists(userEmail)) {
                return "이미 사용 중인 이메일입니다.";
            }

            // 6자리 랜덤 인증번호 생성
            String verificationCode = String.valueOf((int)(Math.random() * 900000) + 100000);

            // 세션에 인증번호와 이메일 저장 (5분간 유효)
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("verificationEmail", userEmail);
            session.setMaxInactiveInterval(300); // 5분

            // 이메일 전송
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("zzzzz0830@gmail.com"); // 🔧 수정: gmail.com (오타 수정)
            message.setTo(userEmail);
            message.setSubject("온라인 도서관 회원가입 인증번호");
            message.setText("안녕하세요!\n\n회원가입 인증번호는 다음과 같습니다:\n\n" +
                    verificationCode + "\n\n5분 내에 입력해주세요.\n\n온라인 도서관 팀");

            mailSender.send(message);

            System.out.println("인증번호 전송 성공: " + verificationCode);
            return "인증번호가 " + userEmail + "로 전송되었습니다.";

        } catch (Exception e) {
            System.err.println("이메일 전송 오류: " + e.getMessage());
            e.printStackTrace();
            return "이메일 전송에 실패했습니다: " + e.getMessage();
        }
    }
}