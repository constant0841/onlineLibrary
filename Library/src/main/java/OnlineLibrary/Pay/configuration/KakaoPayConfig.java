package OnlineLibrary.Pay.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class KakaoPayConfig {

    // application.properties에서 설정값 읽기
    @Value("${kakao.pay.admin-key:27ce9ce201c8a0e34a1763751b719346}")
    private String adminKey;

    @Value("${kakao.pay.cid:TC0ONETIME}")  // 테스트용 CID
    private String cid;

    @Value("${kakao.pay.ready-url:https://kapi.kakao.com/v1/payment/ready}")
    private String readyUrl;

    @Value("${kakao.pay.approve-url:https://kapi.kakao.com/v1/payment/approve}")
    private String approveUrl;

    @Value("${kakao.pay.cancel-url:https://kapi.kakao.com/v1/payment/cancel}")
    private String cancelUrl;

    @Value("${kakao.pay.fail-url:https://kapi.kakao.com/v1/payment/fail}")
    private String failUrl;

    // Getters
    public String getAdminKey() {
        // KakaoAK가 없으면 추가
        return adminKey.startsWith("KakaoAK ") ? adminKey : "KakaoAK " + adminKey;
    }
    public String getCid() { return cid; }
    public String getReadyUrl() { return readyUrl; }
    public String getApproveUrl() { return approveUrl; }
    public String getCancelUrl() { return cancelUrl; }
    public String getFailUrl() { return failUrl; }
}