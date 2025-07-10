package OnlineLibrary.Pay.controller;

import OnlineLibrary.Order.service.OrderService;
import OnlineLibrary.Pay.Service.KakaoPayService;
import OnlineLibrary.User.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private KakaoPayService kakaoPayService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    /**
     * 카카오페이 결제 시작
     */
    @PostMapping("/kakao/ready")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> kakaoPayReady(
            @RequestBody Map<String, Object> paymentRequest,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            // 로그인 확인
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return ResponseEntity.ok(response);
            }

            // 결제 정보 추출
            String orderNumber = "ORDER_" + System.currentTimeMillis();
            String itemName = (String) paymentRequest.getOrDefault("itemName", "도서 주문");
            Integer quantity = (Integer) paymentRequest.getOrDefault("quantity", 1);
            Integer totalAmount = (Integer) paymentRequest.get("totalAmount");

            if (totalAmount == null || totalAmount <= 0) {
                response.put("success", false);
                response.put("message", "결제 금액이 올바르지 않습니다.");
                return ResponseEntity.ok(response);
            }

            // 카카오페이 결제 준비 호출
            Map<String, Object> kakaoResponse = kakaoPayService.kakaoPayReady(
                    orderNumber, userEmail, itemName, quantity, totalAmount
            );

            // 주문 정보를 세션에 임시 저장
            session.setAttribute("temp_order_number", orderNumber);
            session.setAttribute("temp_payment_data", paymentRequest);

            response.put("success", true);
            response.put("orderNumber", orderNumber);
            response.put("redirectUrl", kakaoResponse.get("next_redirect_pc_url"));

            System.out.println("카카오페이 결제 준비 완료 - 주문번호: " + orderNumber);

        } catch (Exception e) {
            System.err.println("카카오페이 결제 준비 중 오류: " + e.getMessage());
            response.put("success", false);
            response.put("message", "결제 준비 중 오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 카카오페이 결제 성공 콜백
     */
    @GetMapping("/kakao/success")
    public String kakaoPaySuccess(@RequestParam("pg_token") String pgToken,
                                  HttpSession session, Model model) {
        try {
            // 세션에서 주문 정보 조회
            String orderNumber = (String) session.getAttribute("temp_order_number");
            @SuppressWarnings("unchecked")
            Map<String, Object> paymentData = (Map<String, Object>) session.getAttribute("temp_payment_data");

            if (orderNumber == null) {
                return "redirect:/cart?error=payment_session_expired";
            }

            // 카카오페이 결제 승인
            Map<String, Object> approveResponse = kakaoPayService.kakaoPayApprove(orderNumber, pgToken);

            // 결제 성공 시 실제 주문 생성
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail != null && paymentData != null) {
                // 실제 주문 생성 로직 (기존 OrderService 사용)
                // OrderEntity order = orderService.createOrderFromPayment(userEmail, paymentData, approveResponse);

                // 임시로 성공 처리
                model.addAttribute("paymentInfo", approveResponse);
                model.addAttribute("orderNumber", orderNumber);

                // 세션 정리
                session.removeAttribute("temp_order_number");
                session.removeAttribute("temp_payment_data");

                System.out.println("카카오페이 결제 완료 - 주문번호: " + orderNumber);

                return "payment/paysuccess";
            }

            return "redirect:/cart?error=payment_process_failed";

        } catch (Exception e) {
            System.err.println("카카오페이 결제 승인 중 오류: " + e.getMessage());
            return "redirect:/cart?error=payment_failed";
        }
    }

    /**
     * 카카오페이 결제 취소 콜백
     */
    @GetMapping("/kakao/cancel")
    public String kakaoPayCancel(HttpSession session) {
        try {
            // 세션 정리
            session.removeAttribute("temp_order_number");
            session.removeAttribute("temp_payment_data");

            System.out.println("카카오페이 결제 취소됨");
            return "redirect:/cart?message=payment_cancelled";

        } catch (Exception e) {
            System.err.println("카카오페이 결제 취소 처리 중 오류: " + e.getMessage());
            return "redirect:/cart?error=cancel_process_failed";
        }
    }

    /**
     * 카카오페이 결제 실패 콜백
     */
    @GetMapping("/kakao/fail")
    public String kakaoPayFail(HttpSession session) {
        try {
            // 세션 정리
            session.removeAttribute("temp_order_number");
            session.removeAttribute("temp_payment_data");

            System.out.println("카카오페이 결제 실패");
            return "redirect:/cart?error=payment_failed";

        } catch (Exception e) {
            System.err.println("카카오페이 결제 실패 처리 중 오류: " + e.getMessage());
            return "redirect:/cart?error=fail_process_error";
        }
    }

    /**
     * 결제 취소 요청 (관리자용)
     */
    @PostMapping("/kakao/cancel")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> cancelPayment(
            @RequestBody Map<String, Object> cancelRequest,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            String orderNumber = (String) cancelRequest.get("orderNumber");
            Integer cancelAmount = (Integer) cancelRequest.get("cancelAmount");

            // 권한 확인 (관리자 또는 주문자 본인)
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            if (isAdmin == null || !isAdmin) {
                response.put("success", false);
                response.put("message", "권한이 없습니다.");
                return ResponseEntity.ok(response);
            }

            // 카카오페이 결제 취소
            Map<String, Object> cancelResponse = kakaoPayService.kakaoPayCancel(orderNumber, cancelAmount);

            response.put("success", true);
            response.put("message", "결제가 취소되었습니다.");
            response.put("cancelInfo", cancelResponse);

        } catch (Exception e) {
            System.err.println("결제 취소 중 오류: " + e.getMessage());
            response.put("success", false);
            response.put("message", "결제 취소 중 오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }
}