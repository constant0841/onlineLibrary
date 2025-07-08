package OnlineLibrary.User.Repository;

import OnlineLibrary.User.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

    // ===== 기본 이메일 조회 =====
    Optional<UserEntity> findByUserEmail(String userEmail);

    // ===== 대소문자 무시 이메일 조회 =====
    @Query("SELECT u FROM UserEntity u WHERE LOWER(u.userEmail) = LOWER(:email)")
    Optional<UserEntity> findByUserEmailIgnoreCase(@Param("email") String userEmail);

    // ===== 이메일 존재 여부 확인 =====
    boolean existsByUserEmail(String userEmail);

    @Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END FROM UserEntity u WHERE LOWER(u.userEmail) = LOWER(:email)")
    boolean existsByUserEmailIgnoreCase(@Param("email") String userEmail);

    // ===== 비밀번호 찾기용 복합 조회 =====
    // 이메일 + 이름 + 전화번호로 사용자 찾기
    Optional<UserEntity> findByUserEmailAndUserNameAndUserPhone(String userEmail, String userName, String userPhone);

    // 대소문자 무시 버전
    @Query("SELECT u FROM UserEntity u WHERE LOWER(u.userEmail) = LOWER(:email) AND u.userName = :name AND u.userPhone = :phone")
    Optional<UserEntity> findByUserEmailAndUserNameAndUserPhoneIgnoreCase(
            @Param("email") String userEmail,
            @Param("name") String userName,
            @Param("phone") String userPhone
    );

}