//package OnlineLibrary.User.controller;
//
//import OnlineLibrary.User.Repository.UserRepository;
//import OnlineLibrary.User.entity.UserEntity;
//import jakarta.servlet.http.HttpSession;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import java.util.Optional;
//
//@Controller
//public class ForgotPasswordController {
//    private final UserRepository userRepository;
//    private final PasswordEncoder passwordEncoder;
//
//    public ForgotPasswordController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
//        this.userRepository = userRepository;
//        this.passwordEncoder = passwordEncoder;
//    }
//
//    // 비밀번호 찾기 폼 보여주기
//    @GetMapping("/forgotPassword")
//    public String showForgotPassword() {
//        return "user/forgotPassword";  // 첫 번째 JSP (사용자 정보 입력)
//    }
//
//    // 사용자 정보 확인 후 인증번호 전송
//    @PostMapping("/resetPassword")
//    public String sendResetCode(@RequestParam String userName,
//                                @RequestParam String userEmail,
//                                @RequestParam String userPhone,
//                                HttpSession session, Model model) {
//        try {
//            // 사용자 정보 확인 (Repository에 이 메서드가 있어야 함)
//            Optional<UserEntity> userOpt = userRepository.findByUserEmailAndUserNameAndUserPhone(
//                    userEmail, userName, userPhone);
//
//            if (!userOpt.isPresent()) {
//                model.addAttribute("errorMsg", "입력하신 정보와 일치하는 사용자를 찾을 수 없습니다.");
//                return "user/forgotPassword";
//            }
//
//            // 인증번호 생성
//            String resetCode = generateResetCode();
//            session.setAttribute("resetCode", resetCode);
//            session.setAttribute("resetEmail", userEmail);
//
//            // TODO: 실제 이메일 전송 로직 구현 필요
//            // emailService.sendResetCode(userEmail, resetCode);
//
//            model.addAttribute("successMsg", "인증번호가 이메일로 전송되었습니다.");
//            return "user/changePassword";  // 두 번째 JSP (인증번호 + 새 비밀번호 입력)
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("errorMsg", "오류가 발생했습니다. 다시 시도해주세요.");
//            return "user/forgotPassword";
//        }
//    }
//
//    // 인증번호 입력 폼 보여주기
//    @GetMapping("/resetPassword")
//    public String showResetPassword(HttpSession session, Model model) {
//        String resetCode = (String) session.getAttribute("resetCode");
//
//        if (resetCode == null) {
//            model.addAttribute("errorMsg", "잘못된 접근입니다. 비밀번호 찾기를 다시 진행해주세요.");
//            return "redirect:/forgotPassword";
//        }
//        return "user/changePassword";  // 두 번째 JSP
//    }
//
//    // 비밀번호 재설정 처리
//    @PostMapping("/resetPassword/confirm")  // URL 변경
//    public String resetPassword(@RequestParam String resetCode,
//                                @RequestParam String newPassword,
//                                @RequestParam String confirmNewPassword,
//                                HttpSession session, Model model) {
//
//        try {
//            String sessionResetCode = (String) session.getAttribute("resetCode");
//            String resetEmail = (String) session.getAttribute("resetEmail");
//
//            if (sessionResetCode == null || resetEmail == null) {
//                model.addAttribute("errorMsg", "인증 시간이 만료되었습니다.");
//                return "user/changePassword";
//            }
//
//            if (!sessionResetCode.equals(resetCode)) {
//                model.addAttribute("errorMsg", "인증번호가 일치하지 않습니다.");
//                return "user/changePassword";
//            }
//
//            if (!newPassword.equals(confirmNewPassword)) {
//                model.addAttribute("errorMsg", "새 비밀번호가 일치하지 않습니다.");
//                return "user/changePassword";
//            }
//
//            if (newPassword.length() < 8) {
//                model.addAttribute("errorMsg", "비밀번호는 8자 이상이어야 합니다.");
//                return "user/changePassword";
//            }
//
//            Optional<UserEntity> userOpt = userRepository.findByUserEmail(resetEmail);
//
//            if (!userOpt.isPresent()) {
//                model.addAttribute("errorMsg", "사용자를 찾을 수 없습니다.");
//                return "user/changePassword";
//            }
//
//            UserEntity user = userOpt.get();
//            String encodedNewPassword = passwordEncoder.encode(newPassword);
//            user.setUserPassword(encodedNewPassword);
//            userRepository.save(user);
//
//            session.removeAttribute("resetCode");
//            session.removeAttribute("resetEmail");
//
//            return "redirect:/login?resetSuccess=true";
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("errorMsg", "비밀번호 변경 중 오류가 발생했습니다.");
//            return "user/changePassword";
//        }
//    }
//
//    // 인증번호 생성 메서드
//    private String generateResetCode() {
//        return String.format("%06d", (int)(Math.random() * 1000000));
//    }
//}