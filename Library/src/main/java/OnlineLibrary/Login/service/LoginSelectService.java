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
        Optional<UserEntity> userOpt = userRepository.findByUserEmail(userEmail);

        if(userOpt.isPresent()) {
            UserEntity user = userOpt.get();
            return passwordEncoder.matches(userPassword, user.getUserPassword());
        }

        return false;
    }
}
