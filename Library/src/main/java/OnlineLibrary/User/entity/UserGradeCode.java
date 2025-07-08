package OnlineLibrary.User.entity;


import jakarta.persistence.*;

@Entity
@Table(name = "user_grade_code")
public class UserGradeCode {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_grade_code", length = 20)
    private String userGradeCode;

    @Column(name = "user_grade_name", length = 20)
    private String userGradeName;
}
