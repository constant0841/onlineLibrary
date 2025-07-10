package OnlineLibrary.User.Configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // 이미 CSRF가 비활성화되어 있어서 좋음
                .authorizeHttpRequests(auth -> auth
                        // 모든 페이지 허용 (개발용) - 이것도 이미 잘 설정됨
                        .requestMatchers("/**").permitAll()
                )
                // 세션 관리 추가 (중요!)
                .sessionManagement(session -> session
                        .sessionCreationPolicy(org.springframework.security.config.http.SessionCreationPolicy.IF_REQUIRED)
                        .maximumSessions(1)
                        .maxSessionsPreventsLogin(false)
                )
//                .formLogin(form -> form
//                        .loginPage("/login")
////                        .loginProcessingUrl("/loginProcess")
//                        .usernameParameter("userEmail")
//                        .passwordParameter("userPassword")
//                        .defaultSuccessUrl("/main", true)
//                        .failureUrl("/loginerror")
//                        .permitAll()
//                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/main")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                );

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}