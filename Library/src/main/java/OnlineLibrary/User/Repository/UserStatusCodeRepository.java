package OnlineLibrary.User.Repository;

import OnlineLibrary.User.entity.UserStatusCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserStatusCodeRepository extends JpaRepository<UserStatusCode, String> {

    /**
     * 상태 코드로 조회
     */
    Optional<UserStatusCode> findByUserStatusCode(String userStatusCode);

    /**
     * 상태명으로 조회
     */
    Optional<UserStatusCode> findByUserStatus(String userStatus);

    /**
     * 상태명 포함 검색
     */
    List<UserStatusCode> findByUserStatusContaining(String userStatus);

    /**
     * 모든 상태 코드 조회 (정렬)
     */
    List<UserStatusCode> findAllByOrderByUserStatusCodeAsc();
}