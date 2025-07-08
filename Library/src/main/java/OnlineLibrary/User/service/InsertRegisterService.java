package OnlineLibrary.User.service;

import OnlineLibrary.User.dto.InsertRegisterDTO;
import OnlineLibrary.User.Repository.UserRepository;
import OnlineLibrary.User.entity.UserEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
public class InsertRegisterService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public InsertRegisterService(UserRepository userRepository, PasswordEncoder passwordEncoder){
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // 이메일 중복 체크 (대소문자 무시)
    public boolean isEmailExists(String userEmail){
        return userRepository.existsByUserEmailIgnoreCase(userEmail);
    }

    public boolean registerUser(InsertRegisterDTO registerDTO){
        // 중복 체크 (대소문자 무시)
        if(isEmailExists(registerDTO.getUserEmail())){
            System.out.println("이메일 중복: " + registerDTO.getUserEmail());
            return false;
        }

        try {
            UserEntity user = new UserEntity();

            // 기본 정보
            user.setUserEmail(registerDTO.getUserEmail().toLowerCase()); // 소문자로 저장
            user.setUserName(registerDTO.getUserName());

            // 전화번호 정리 (하이픈 제거)
            String cleanPhone = registerDTO.getUserPhone().replace("-", "");
            user.setUserPhone(cleanPhone);

            user.setUserAddress(registerDTO.getUserAddress());

            // 비밀번호 암호화
            String encodedPassword = passwordEncoder.encode(registerDTO.getUserPassword());
            user.setUserPassword(encodedPassword);

            // 추가 정보
            user.setUserPostalCode(registerDTO.getUserPostalCode());
            user.setUserAddressDetail(registerDTO.getUserAddressDetail());
            user.setUserBirthDate(registerDTO.getUserBirthDate());
            user.setUserGenderId(registerDTO.getUserGenderId());
            user.setUserJob(registerDTO.getUserJob());

            // 체크박스 처리
            user.setUserIsAdReceive("on".equals(registerDTO.getUserIsAdReceive()));

            // 기본값 설정
            user.setIsAdmin(false);
            user.setCreatedAt(LocalDate.now());

            userRepository.save(user);

            System.out.println("회원가입 성공: " + user.getUserEmail());
            return true;

        } catch (Exception e) {
            System.err.println("회원가입 중 오류: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}