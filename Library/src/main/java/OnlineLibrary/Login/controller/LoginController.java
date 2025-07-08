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
        System.out.println("로그인 결과" + isValid);

        if (isValid) {
            session.setAttribute("userEmail", userEmail);

            if(registerDTO.getRememberEmail()){
                Cookie cookie = new Cookie("email", registerDTO.getUserEmail());
                cookie.setMaxAge(60*60*24);
                cookie.setPath("/");
                response.addCookie(cookie);
            }

            return "redirect:/main";
        } else {
            model.addAttribute("errorMsg", "이메일 또는 비밀번호가 틀렸습니다.");
            return "login/loginPage";
        }

    }

}