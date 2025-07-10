package OnlineLibrary.User.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "user_status_code")
@Getter @Setter
public class UserStatusCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_status_code", length = 20)
    private String userStatusCode;

    @Column(name = "user_status", length = 20)
    private String userStatus;
}
