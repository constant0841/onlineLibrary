package OnlineLibrary.User.service;

import OnlineLibrary.User.Repository.UserRepository;
import OnlineLibrary.User.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    /**
     * 이메일 중복 확인 (탈퇴하지 않은 사용자)
     */
    public boolean isWithdrawn(String userEmail) {
        // 사용자가 존재하고 탈퇴하지 않았는지 확인
        Optional<UserEntity> userOpt = userRepository.findByUserEmail(userEmail);
        if (userOpt.isPresent()) {
            UserEntity user = userOpt.get();
            // UserWithdrawal 테이블에 해당 사용자가 있는지 확인하는 로직 필요
            // 현재는 간단히 사용자 존재 여부로 판단
            return false; // 추후 탈퇴 테이블 조회 로직 추가 필요
        }
        return true; // 사용자가 없으면 탈퇴했다고 가정
    }

    /**
     * 활성 사용자 수 조회 (탈퇴하지 않은 사용자)
     */
    public long getActiveUserCount() {
        try {
            return userRepository.countActiveUsers();
        } catch (Exception e) {
            System.err.println("활성 사용자 수 조회 중 오류 발생: " + e.getMessage());
            return 0;
        }
    }

    /**
     * 사용자 상태 업데이트 (코치용)
     */
    public boolean updateUserStatus(Long userId, String userStatusCode) {
        try {
            Optional<UserEntity> userOpt = userRepository.findById(userId);
            if (userOpt.isPresent()) {
                UserEntity user = userOpt.get();

                // UserStatusCode 엔티티 설정 (실제 구조에 맞게 수정 필요)
                // user.setUserStatusCode(userStatusCode); // 직접 설정 또는
                // UserStatusCode statusCode = userStatusCodeRepository.findById(userStatusCode);
                // user.setUserStatusCode(statusCode);

                userRepository.save(user);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("사용자 상태 업데이트 중 오류 발생: " + e.getMessage());
            return false;
        }
    }

    /**
     * 활성 사용자 목록 조회
     */
    public List<UserEntity> getActiveUsers() {
        try {
            return userRepository.findActiveUsers();
        } catch (Exception e) {
            System.err.println("활성 사용자 목록 조회 중 오류 발생: " + e.getMessage());
            return List.of(); // 빈 리스트 반환
        }
    }

    /**
     * 탈퇴 사용자 목록 조회
     */
    public List<UserEntity> getWithdrawnUsers() {
        try {
            return userRepository.findWithdrawnUsers();
        } catch (Exception e) {
            System.err.println("탈퇴 사용자 목록 조회 중 오류 발생: " + e.getMessage());
            return List.of();
        }
    }

    /**
     * 이름으로 활성 사용자 검색
     */
    public List<UserEntity> searchActiveUsersByName(String userName) {
        try {
            return userRepository.findActiveUsersByUserNameContaining(userName);
        } catch (Exception e) {
            System.err.println("사용자 이름 검색 중 오류 발생: " + e.getMessage());
            return List.of();
        }
    }

    /**
     * 특정 상태 코드인 활성 사용자 수 조회
     */
    public long getActiveUserCountByStatusCode(String statusCode) {
        try {
            return userRepository.countActiveUsersByStatusCode(statusCode);
        } catch (Exception e) {
            System.err.println("상태별 활성 사용자 수 조회 중 오류 발생: " + e.getMessage());
            return 0;
        }
    }

    /**
     * 특정 상태 코드인 사용자 목록 조회 (탈퇴 여부 무관)
     */
    public List<UserEntity> getUsersByStatusCode(String statusCode) {
        try {
            return userRepository.findByUserStatusCode_UserStatusCode(statusCode);
        } catch (Exception e) {
            System.err.println("상태별 사용자 목록 조회 중 오류 발생: " + e.getMessage());
            return List.of();
        }
    }

    /**
     * 이메일로 사용자 조회
     */
    public Optional<UserEntity> findByEmail(String userEmail) {
        try {
            return userRepository.findByUserEmail(userEmail);
        } catch (Exception e) {
            System.err.println("이메일로 사용자 조회 중 오류 발생: " + e.getMessage());
            return Optional.empty();
        }
    }

    /**
     * 이메일 존재 여부 확인
     */
    public boolean existsByEmail(String userEmail) {
        try {
            return userRepository.existsByUserEmail(userEmail);
        } catch (Exception e) {
            System.err.println("이메일 존재 여부 확인 중 오류 발생: " + e.getMessage());
            return false;
        }
    }

    /**
     * 사용자 저장
     */
    public UserEntity saveUser(UserEntity user) {
        try {
            return userRepository.save(user);
        } catch (Exception e) {
            System.err.println("사용자 저장 중 오류 발생: " + e.getMessage());
            throw new RuntimeException("사용자 저장에 실패했습니다.", e);
        }
    }

    /**
     * 사용자 ID로 조회
     */
    public Optional<UserEntity> findById(Long userId) {
        try {
            return userRepository.findById(userId);
        } catch (Exception e) {
            System.err.println("사용자 ID로 조회 중 오류 발생: " + e.getMessage());
            return Optional.empty();
        }
    }

    /**
     * 복합 조건으로 사용자 찾기 (비밀번호 찾기용)
     */
    public Optional<UserEntity> findByEmailAndNameAndPhone(String userEmail, String userName, String userPhone) {
        try {
            return userRepository.findByUserEmailAndUserNameAndUserPhone(userEmail, userName, userPhone);
        } catch (Exception e) {
            System.err.println("복합 조건 사용자 조회 중 오류 발생: " + e.getMessage());
            return Optional.empty();
        }
    }
}