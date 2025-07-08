package OnlineLibrary.User.Repository;

import OnlineLibrary.User.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    // 이메일 찾기
    Optional<UserEntity> findByUserEmail(String Email);

    //이메일 중복 체크
    boolean existsByUserEmail(String userEmail);

    Optional<UserEntity> findByUserEmailAndUserNameAndUserPhone(String userEmail, String userName, String userPhone);

}
