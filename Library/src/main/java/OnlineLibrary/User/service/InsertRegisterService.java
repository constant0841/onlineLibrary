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

    public boolean isEmailExists(String userEmail){
        return userRepository.existsByUserEmail(userEmail);
    }

    public boolean registerUser(InsertRegisterDTO registerDTO){
        if(isEmailExists(registerDTO.getUserEmail())){ // 중복이면 false
            return false;
        }

        UserEntity user = new UserEntity();

        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(registerDTO.getUserPassword());
        user.setUserPassword(encodedPassword);

        // 기본 정보
        user.setUserEmail(registerDTO.getUserEmail());
        user.setUserName(registerDTO.getUserName());
        user.setUserPhone(registerDTO.getUserPhone());
        user.setUserAddress(registerDTO.getUserAddress());

        // 추가 정보
        user.setUserPostalCode(registerDTO.getUserPostalCode());
        user.setUserAddressDetail(registerDTO.getUserAddressDetail());

        // 생년월일 - String 그대로 저장
        user.setUserBirthDate(registerDTO.getUserBirthDate());

        user.setUserGenderId(registerDTO.getUserGenderId());

        // 직업 - String 그대로 저장 (Entity가 String 타입이므로)
        user.setUserJob(registerDTO.getUserJob());

        // 체크박스 처리
        user.setUserIsAdReceive("on".equals(registerDTO.getUserIsAdReceive()));

        // 기본값 설정
        user.setIsAdmin(false);
        user.setCreatedAt(LocalDate.now());

        userRepository.save(user);
        return true;
    }


}