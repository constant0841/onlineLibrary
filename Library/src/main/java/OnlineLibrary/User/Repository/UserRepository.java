package OnlineLibrary.User.Repository;

import OnlineLibrary.User.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
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

    // ===== UserWithdrawal 테이블과 JOIN을 통한 사용자 관리 =====

    /**
     * 활성 사용자 수 조회 (탈퇴하지 않은 사용자)
     * UserWithdrawal 테이블에 해당 사용자가 없는 경우
     */
    @Query("SELECT COUNT(u) FROM UserEntity u WHERE u.userId NOT IN (SELECT uw.userId FROM UserWithdrawal uw)")
    long countActiveUsers();

    /**
     * 탈퇴 사용자 수 조회
     * UserWithdrawal 테이블에 해당 사용자가 있는 경우
     */
    @Query("SELECT COUNT(u) FROM UserEntity u WHERE u.userId IN (SELECT uw.userId FROM UserWithdrawal uw)")
    long countWithdrawnUsers();

    /**
     * 활성 사용자 조회 (탈퇴하지 않은 사용자)
     */
    @Query("SELECT u FROM UserEntity u WHERE u.userId NOT IN (SELECT uw.userId FROM UserWithdrawal uw) ORDER BY u.createdAt DESC")
    List<UserEntity> findActiveUsers();

    /**
     * 탈퇴 사용자 조회
     */
    @Query("SELECT u FROM UserEntity u WHERE u.userId IN (SELECT uw.userId FROM UserWithdrawal uw) ORDER BY u.createdAt DESC")
    List<UserEntity> findWithdrawnUsers();

    /**
     * 특정 날짜에 탈퇴한 사용자 조회
     */
    @Query("SELECT u FROM UserEntity u JOIN UserWithdrawal uw ON u.userId = uw.userId WHERE uw.withdrawalDate = :withdrawalDate")
    List<UserEntity> findUsersByWithdrawalDate(@Param("withdrawalDate") LocalDate withdrawalDate);

    /**
     * 특정 기간에 탈퇴한 사용자 조회
     */
    @Query("SELECT u FROM UserEntity u JOIN UserWithdrawal uw ON u.userId = uw.userId WHERE uw.withdrawalDate BETWEEN :startDate AND :endDate")
    List<UserEntity> findUsersByWithdrawalDateBetween(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);

    /**
     * 최근 가입자 조회 (활성 사용자만) - 상위 10명
     */
    @Query("SELECT u FROM UserEntity u WHERE u.userId NOT IN (SELECT uw.userId FROM UserWithdrawal uw) ORDER BY u.createdAt DESC LIMIT 10")
    List<UserEntity> findTop10ActiveUsersByCreatedAt();

    /**
     * 이름으로 사용자 검색 (활성 사용자만)
     */
    @Query("SELECT u FROM UserEntity u WHERE u.userId NOT IN (SELECT uw.userId FROM UserWithdrawal uw) AND u.userName LIKE %:userName%")
    List<UserEntity> findActiveUsersByUserNameContaining(@Param("userName") String userName);

    /**
     * 활성 사용자 중 특정 상태 코드인 사용자 조회
     */
    @Query("SELECT u FROM UserEntity u WHERE u.userId NOT IN (SELECT uw.userId FROM UserWithdrawal uw) AND u.userStatusCode.userStatusCode = 'ACTIVE' ORDER BY u.createdAt DESC")
    List<UserEntity> findActiveUsersWithActiveStatus();

    // ===== 상태 코드 기반 조회 =====

    /**
     * 활성 사용자 중 특정 상태 코드인 사용자 수 조회
     */
    @Query("SELECT COUNT(u) FROM UserEntity u WHERE u.userId NOT IN (SELECT uw.userId FROM UserWithdrawal uw) AND u.userStatusCode.userStatusCode = :statusCode")
    long countActiveUsersByStatusCode(@Param("statusCode") String statusCode);

    /**
     * 특정 상태 코드인 사용자 조회 (탈퇴 여부 무관)
     */
    List<UserEntity> findByUserStatusCode_UserStatusCode(String statusCode);

    // ===== 탈퇴 정보와 함께 조회하는 메서드들 =====

    /**
     * 사용자와 탈퇴 정보 함께 조회
     */
    @Query("SELECT u FROM UserEntity u LEFT JOIN UserWithdrawal uw ON u.userId = uw.userId WHERE u.userId = :userId")
    Optional<UserEntity> findUserWithWithdrawalInfo(@Param("userId") Integer userId);

    /**
     * 탈퇴 사유별 사용자 조회
     */
    @Query("SELECT u FROM UserEntity u JOIN UserWithdrawal uw ON u.userId = uw.userId WHERE uw.withdrawalReason LIKE %:reason%")
    List<UserEntity> findUsersByWithdrawalReason(@Param("reason") String reason);

}