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
                return isAdmin != null && isAdmin;
            } else {
                return null;
            }

        } catch (Exception e) {
            System.err.println("관리자 권한 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 사용자 정보 전체 조회 (필요시 사용)
     * @param userEmail 사용자 이메일
     * @return UserEntity 객체 또는 null
     */
    public UserEntity getUserByEmail(String userEmail) {
        try {
            // 대소문자 무시하고 검색
            Optional<UserEntity> userOpt = userRepository.findByUserEmailIgnoreCase(userEmail);
            return userOpt.orElse(null);
        } catch (Exception e) {
            System.err.println("사용자 정보 조회 중 오류: " + e.getMessage());
            return null;
        }
    }
}