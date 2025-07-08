package OnlineLibrary.Login.controller;

import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LogoutController {
    @PostMapping("/logout")
    public String goLogout(HttpSession session){
        session.removeAttribute("userEmail");

        session.invalidate();

        return "redirect:/main";
    }


}
