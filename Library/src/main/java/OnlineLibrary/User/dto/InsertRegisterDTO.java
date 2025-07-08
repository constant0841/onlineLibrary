package OnlineLibrary.User.dto;

import lombok.Getter;
import lombok.Setter;



@Getter @Setter
public class InsertRegisterDTO {
    private String userEmail;
    private String userPassword;
    private String userName;
    private String userPhone;
    private String userAddress;
    private String emailVerifyCode;
    private String userPostalCode;
    private String userAddressDetail;
    private String userBirthDate;
    private String userGenderId;
    private String userJob;
    private Boolean userIsAdReceive;
    private Boolean rememberEmail;
    private Boolean isAdmin;

    public InsertRegisterDTO(){}
}
