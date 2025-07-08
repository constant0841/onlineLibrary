package OnlineLibrary.User.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "user_status_code")
public class UserStatusCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_status_code", length = 20)
    private String userStatusCode;

    @Column(name = "user_status", length = 20)
    private String userStatus;
}
