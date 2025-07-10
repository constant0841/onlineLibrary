package OnlineLibrary.User.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "user_grade_code")
@Getter @Setter
public class UserGradeCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_grade_code", length = 20)
    private String userGradeCode;

    @Column(name = "user_grade_name", length = 20)
    private String userGradeName;
}
