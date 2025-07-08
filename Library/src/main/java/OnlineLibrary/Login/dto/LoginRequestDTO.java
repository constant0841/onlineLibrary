package OnlineLibrary.Login.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class LoginRequestDTO {
    private String userLoginId;
    private String userPassword;

    public LoginRequestDTO(){}
}
