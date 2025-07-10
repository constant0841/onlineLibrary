package OnlineLibrary.Login.service;

import OnlineLibrary.User.Repository.UserRepository;
import OnlineLibrary.User.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class LoginSelectService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public boolean checkedLogin(String userEmail, String userPassword){
        // 대소문자 무시하고 검색
        Optional<UserEntity> userOpt = userRepository.findByUserEmailIgnoreCase(userEmail);

        if(userOpt.isPresent()) {
            UserEntity user = userOpt.get();
            return passwordEncoder.matches(userPassword, user.getUserPassword());
        }

        return false;
    }

    /**
     * 사용자의 관리자 권한 여부 조회
     * @param userEmail 사용자 이메일
     * @return 관리자면 true, 일반사용자면 false, 사용자가 없으면 null
     */
    public Boolean isUserAdmin(String userEmail) {
        try {
            // 대소문자 무시하고 검색
            Optional<UserEntity> userOpt = userRepository.findByUserEmailIgnoreCase(userEmail);

            if (userOpt.isPresent()) {
                UserEntity user = userOpt.get();
                Boolean isAdmin = user.getIsAdmin();
                // isAdmin이 null이 아니고 true일 경우에만 true 반환
                return isAdmin != null && isAdmin;
            } else {
                // 사용자가 존재하지 않으면 null 반환
                return null;
            }

        } catch (Exception e) {
            System.err.println("관리자 권한 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            return false; // 오류 발생 시 안전하게 false 반환
        }
    }

    /**
     * 사용자 정보 전체 조회 (Optional<UserEntity> 반환)
     * 이메일을 기반으로 UserEntity를 조회합니다.
     * @param userEmail 사용자 이메일
     * @return UserEntity를 담고 있는 Optional 객체. 사용자가 없으면 빈 Optional 반환.
     */
    public Optional<UserEntity> getUserByEmail(String userEmail) {
        try {
            // 대소문자 무시하고 검색하여 Optional<UserEntity> 반환
            return userRepository.findByUserEmailIgnoreCase(userEmail);
        } catch (Exception e) {
            System.err.println("사용자 정보 조회 중 오류: " + e.getMessage());
            // 예외 발생 시 빈 Optional 반환하여 호출 측에서 null 체크 대신 isPresent()로 확인 가능
            return Optional.empty();
        }
    }
}