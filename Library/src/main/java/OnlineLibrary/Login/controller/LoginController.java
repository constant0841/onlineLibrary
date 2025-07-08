package OnlineLibrary.Login.controller;

import OnlineLibrary.Login.service.LoginSelectService;
import OnlineLibrary.User.dto.InsertRegisterDTO;
import jakarta.servlet.http.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
    @Autowired
    LoginSelectService loginSelectService;

    @GetMapping("/login")
    public String goLogin(HttpServletRequest request,
                          @ModelAttribute("registerDTO") InsertRegisterDTO registerDTO){
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for (Cookie cookie : cookies){
                if("email".equals(cookie.getName())){
                    registerDTO.setUserEmail(cookie.getValue());
                    registerDTO.setRememberEmail(true);
                }
            }
        }

        return "login/loginPage";
    }

    @PostMapping("/login")
    public String checkLogin(@RequestParam String userEmail, @RequestParam String userPassword,
                             Model model, HttpSession session, InsertRegisterDTO registerDTO,
                             HttpServletResponse response) {
        System.out.println("=== 로그인 요청 ===");
        System.out.println("이메일: '" + userEmail + "'");
        System.out.println("비밀번호: '" + userPassword + "'");

        boolean isValid = loginSelectService.checkedLogin(userEmail, userPassword);
        System.out.println("로그인 결과: " + isValid);

        if (isValid) {
            try {
                // 세션에 기본 사용자 정보 저장
                session.setAttribute("userEmail", userEmail);

                // 🔧 추가: 관리자 권한 체크 및 세션 저장
                Boolean isAdmin = loginSelectService.isUserAdmin(userEmail);
                System.out.println("isAdmin from DB: " + isAdmin + " / type: " + (isAdmin != null ? isAdmin.getClass().getName() : "null"));
                if (isAdmin != null && isAdmin) {
                    session.setAttribute("isAdmin", true);
                    System.out.println("관리자 로그인: " + userEmail);
                } else {
                    session.setAttribute("isAdmin", false);
                    System.out.println("일반 사용자 로그인: " + userEmail);
                }

                // 이메일 기억하기 쿠키 처리
                if(registerDTO.getRememberEmail()){
                    Cookie cookie = new Cookie("email", registerDTO.getUserEmail());
                    cookie.setMaxAge(60*60*24);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }

                return "redirect:/main";

            } catch (Exception e) {
                System.err.println("로그인 처리 중 오류: " + e.getMessage());
                // 오류 발생 시 기본적으로 일반 사용자로 처리
                session.setAttribute("isAdmin", false);
                return "redirect:/main";
            }

        } else {
            model.addAttribute("errorMsg", "이메일 또는 비밀번호가 틀렸습니다.");
            return "login/loginPage";
        }
    }

}