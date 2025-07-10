package OnlineLibrary.Pay.Service;

import OnlineLibrary.Pay.configuration.KakaoPayConfig;
import OnlineLibrary.Pay.DTO.KakaoPayReadyRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class KakaoPayService {

    @Autowired
    private KakaoPayConfig kakaoPayConfig;

    private final RestTemplate restTemplate = new RestTemplate();

    // 임시 저장소 (실제로는 Redis나 DB 사용 권장)
    private Map<String, String> paymentTempStorage = new HashMap<>();

    /**
     * 카카오페이 결제 준비
     */
    public Map<String, Object> kakaoPayReady(String orderNumber, String userEmail,
                                             String itemName, Integer quantity, Integer totalAmount) {
        try {
            System.out.println("=== 카카오페이 결제 준비 시작 ===");
            System.out.println("Admin Key: " + kakaoPayConfig.getAdminKey());
            System.out.println("CID: " + kakaoPayConfig.getCid());
            System.out.println("주문번호: " + orderNumber);
            System.out.println("총 금액: " + totalAmount);

            // HTTP 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.add("Authorization", kakaoPayConfig.getAdminKey());
            headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

            // 요청 파라미터 설정
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("cid", kakaoPayConfig.getCid());
            params.add("partner_order_id", orderNumber);
            params.add("partner_user_id", userEmail);
            params.add("item_name", itemName);
            params.add("quantity", String.valueOf(quantity));
            params.add("total_amount", String.valueOf(totalAmount));
            params.add("tax_free_amount", "0");
            params.add("approval_url", "http://localhost:8080/payment/kakao/success");
            params.add("cancel_url", "http://localhost:8080/payment/kakao/cancel");
            params.add("fail_url", "http://localhost:8080/payment/kakao/fail");

            System.out.println("요청 파라미터: " + params);

            // HTTP 엔티티 생성
            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);

            // 카카오페이 API 호출
            Map<String, Object> response = restTemplate.postForObject(
                    kakaoPayConfig.getReadyUrl(),
                    entity,
                    Map.class
            );

            System.out.println("카카오페이 응답: " + response);

            if (response != null && response.containsKey("tid")) {
                // TID를 임시 저장 (실제로는 Redis나 DB 사용)
                String tid = (String) response.get("tid");
                paymentTempStorage.put(orderNumber + "_tid", tid);
                paymentTempStorage.put(orderNumber + "_user", userEmail);

                System.out.println("카카오페이 결제 준비 성공 - TID: " + tid);
                return response;
            } else {
                throw new RuntimeException("카카오페이 결제 준비 실패");
            }

        } catch (Exception e) {
            System.err.println("카카오페이 결제 준비 중 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("카카오페이 결제 준비 실패: " + e.getMessage());
        }
    }

    /**
     * 카카오페이 결제 승인
     */
    public Map<String, Object> kakaoPayApprove(String orderNumber, String pgToken) {
        try {
            // 저장된 TID와 사용자 정보 조회
            String tid = paymentTempStorage.get(orderNumber + "_tid");
            String userEmail = paymentTempStorage.get(orderNumber + "_user");

            if (tid == null) {
                throw new RuntimeException("결제 정보를 찾을 수 없습니다.");
            }

            // HTTP 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.add("Authorization", "KakaoAK " + kakaoPayConfig.getAdminKey());
            headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

            // 요청 파라미터 설정
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("cid", kakaoPayConfig.getCid());
            params.add("tid", tid);
            params.add("partner_order_id", orderNumber);
            params.add("partner_user_id", userEmail);
            params.add("pg_token", pgToken);

            // HTTP 엔티티 생성
            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);

            // 카카오페이 결제 승인 API 호출
            Map<String, Object> response = restTemplate.postForObject(
                    kakaoPayConfig.getApproveUrl(),
                    entity,
                    Map.class
            );

            if (response != null && response.containsKey("aid")) {
                // 결제 완료 후 임시 저장소에서 제거
                paymentTempStorage.remove(orderNumber + "_tid");
                paymentTempStorage.remove(orderNumber + "_user");

                System.out.println("카카오페이 결제 승인 성공 - AID: " + response.get("aid"));
                return response;
            } else {
                throw new RuntimeException("카카오페이 결제 승인 실패");
            }

        } catch (Exception e) {
            System.err.println("카카오페이 결제 승인 중 오류: " + e.getMessage());
            throw new RuntimeException("카카오페이 결제 승인 실패: " + e.getMessage());
        }
    }

    /**
     * 카카오페이 결제 취소
     */
    public Map<String, Object> kakaoPayCancel(String orderNumber, Integer cancelAmount) {
        try {
            String tid = paymentTempStorage.get(orderNumber + "_tid");

            if (tid == null) {
                throw new RuntimeException("취소할 결제 정보를 찾을 수 없습니다.");
            }

            // HTTP 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.add("Authorization", "KakaoAK " + kakaoPayConfig.getAdminKey());
            headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

            // 요청 파라미터 설정
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("cid", kakaoPayConfig.getCid());
            params.add("tid", tid);
            params.add("cancel_amount", String.valueOf(cancelAmount));
            params.add("cancel_tax_free_amount", "0");

            // HTTP 엔티티 생성
            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);

            // 카카오페이 결제 취소 API 호출
            Map<String, Object> response = restTemplate.postForObject(
                    kakaoPayConfig.getCancelUrl(),
                    entity,
                    Map.class
            );

            System.out.println("카카오페이 결제 취소 성공");
            return response;

        } catch (Exception e) {
            System.err.println("카카오페이 결제 취소 중 오류: " + e.getMessage());
            throw new RuntimeException("카카오페이 결제 취소 실패: " + e.getMessage());
        }
    }

    /**
     * 결제 정보 임시 저장 (개발용)
     */
    public void savePaymentInfo(String key, String value) {
        paymentTempStorage.put(key, value);
    }

    /**
     * 결제 정보 조회 (개발용)
     */
    public String getPaymentInfo(String key) {
        return paymentTempStorage.get(key);
    }
}