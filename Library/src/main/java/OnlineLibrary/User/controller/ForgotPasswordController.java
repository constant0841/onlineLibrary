package OnlineLibrary.User.controller;

import OnlineLibrary.User.Repository.UserRepository;
import OnlineLibrary.User.entity.UserEntity;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class ForgotPasswordController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public ForgotPasswordController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/forgotPassword")
    public String showResetPassword(HttpSession session, Model model){
        String resetCode = (String) session.getAttribute("resetCode");

        if(resetCode == null){
            model.addAttribute("errorMsg", "잘못된 접근입니다.");
            return "user/changePassword";
        }
        return "user/forgotPassword";
    }

    @PostMapping("/forgotPassword")
    public String goResetPassword(@RequestParam String resetCode,
                                  @RequestParam String newPassword,
                                  @RequestParam String confirmNewPassword,
                                  HttpSession session, Model model){

        try {
            String sessionResetCode = (String) session.getAttribute("resetCode");
            String resetEmail = (String) session.getAttribute("resetEmail");

            if(sessionResetCode == null || resetEmail == null){
                model.addAttribute("errorMsg", "인증 시간이 만료 되었습니다.");
                return "user/forgotPassword";
            }

            if(!sessionResetCode.equals(resetCode)){
                model.addAttribute("errorMsg", "인증번호가 일치하지 않습니다.");
                return "user/forgotPassword";
            }

            if(!newPassword.equals(confirmNewPassword)) {
                model.addAttribute("errorMsg", "새 비밀번호가 일치하지 않습니다.");
                return "user/forgotPassword";
            }

            if (newPassword.length() < 8) {
                model.addAttribute("errorMsg", "비밀번호는 8자 이상이어야 합니다.");
                return "user/forgotPassword";
            }

            Optional<UserEntity> userOpt = userRepository.findByUserEmail(resetEmail);

            if (!userOpt.isPresent()) {
                model.addAttribute("errorMsg", "사용자를 찾을 수 없습니다.");
                return "user/forgotPassword";
            }

            UserEntity user = userOpt.get();

            String encodedNewPassword = passwordEncoder.encode(newPassword);
            user.setUserPassword(encodedNewPassword);
            userRepository.save(user);

            session.removeAttribute("resetCode");
            session.removeAttribute("resetEmail");

            return "redirect:/login?resetSuccess=true";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "비밀번호 변경 중 오류가 발생했습니다.");
            return "user/forgotPassword";
        }
    }
}
