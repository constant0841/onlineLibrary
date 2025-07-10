package OnlineLibrary.User.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Getter @Setter
@Table(name = "user")
public class UserEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "user_name", length = 20)
    private String userName;

    @Column(name = "user_password", length = 255)
    private String userPassword;

    @Column(name = "user_email", length = 30)
    private String userEmail;

    @Column(name = "user_phone", length = 20)
    private String userPhone;

    @Column(name = "user_address", length = 100)
    private String userAddress;

    @Column(name = "is_admin", columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean isAdmin;

    @ManyToOne
    @JoinColumn(name = "user_status_code")
    private UserStatusCode userStatusCode;

//    @ManyToOne
//    @JoinColumn(name = "user_grade_code")
//    private UserGradeCode userGrade;

    @Column(name = "created_at")
    private LocalDate createdAt;

    @Column(name = "last_login_at")
    private LocalDate lastLoginAt;

    @Column(name = "email_verify_code", length = 20)
    private String emailVerifyCode;
    
    @Column(name = "user_postal_code", length = 10)
    private String userPostalCode;          // 우편번호

    @Column(name = "user_address_detail", length = 100)
    private String userAddressDetail;       // 상세주소

    @Column(name = "user_birth_date")
    private String userBirthDate;        // 생년월일

    @Column(name = "user_gender_id", length = 1)
    private String userGenderId;            // 성별 (M/F)

    @Column(name = "user_job", length = 20)
    private String userJob;              // 직업 (1,2,3,4)

    @Column(name = "user_is_ad_receive", columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean userIsAdReceive;        // 광고수신동의

}