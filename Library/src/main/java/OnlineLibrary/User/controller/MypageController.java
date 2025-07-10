package OnlineLibrary.User.controller;

import OnlineLibrary.Order.entity.OrderEntity;
import OnlineLibrary.Order.service.OrderService;
import OnlineLibrary.User.entity.UserEntity;
import OnlineLibrary.User.service.UserService;
import OnlineLibrary.Pay.Service.KakaoPayService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/mypage")
public class MypageController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private KakaoPayService kakaoPayService;

    // MypageController에 이 간단한 메서드들을 추가하세요

    /**
     * Controller 작동 테스트
     */
    @GetMapping("/test")
    @ResponseBody
    public String test() {
        System.out.println("=== /mypage/test 호출됨 ===");
        return "Controller 작동 중! 현재 시간: " + new java.util.Date();
    }
// MypageController에 이 메서드를 추가해서 매핑 상태 확인

    @GetMapping("/debug-mappings")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> debugMappings() {
        Map<String, Object> response = new HashMap<>();

        System.out.println("=== 디버그: 매핑 확인 ===");

        response.put("success", true);
        response.put("message", "매핑이 정상적으로 등록됨");
        response.put("timestamp", new java.util.Date());
        response.put("controllerClass", this.getClass().getSimpleName());

        // 현재 등록된 메서드들 확인
        java.lang.reflect.Method[] methods = this.getClass().getDeclaredMethods();
        java.util.List<String> methodList = new java.util.ArrayList<>();

        for (java.lang.reflect.Method method : methods) {
            if (method.isAnnotationPresent(GetMapping.class) ||
                    method.isAnnotationPresent(PostMapping.class) ||
                    method.isAnnotationPresent(RequestMapping.class)) {
                methodList.add(method.getName());
                System.out.println("매핑된 메서드: " + method.getName());
            }
        }

        response.put("mappedMethods", methodList);

        return ResponseEntity.ok(response);
    }

    /**
     * 주문 취소 테스트 (단순 버전)
     */
    @PostMapping("/orders/test-cancel")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> testCancel() {
        System.out.println("=== /mypage/orders/test-cancel 호출됨 ===");

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "테스트 취소 성공!");

        return ResponseEntity.ok(response);
    }


    /**
     * 마이페이지 메인
     */
    @GetMapping("")
    public String mypage(HttpSession session, Model model) {
        try {
            // 로그인 확인
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                return "redirect:/login?redirect=/mypage";
            }

            // 사용자 정보 조회
            Optional<UserEntity> userOpt = userService.findByEmail(userEmail);
            if (!userOpt.isPresent()) {
                return "redirect:/login?error=user_not_found";
            }

            UserEntity user = userOpt.get();

            // 사용자 주문 통계
            List<OrderEntity> userOrders = orderService.findOrdersByUser(user);
            long totalOrders = userOrders.size();

            // 최근 주문 (최대 5개)
            List<OrderEntity> recentOrders = userOrders.size() > 5 ?
                    userOrders.subList(0, 5) : userOrders;

            // 모델에 데이터 추가
            model.addAttribute("user", user);
            model.addAttribute("totalOrders", totalOrders);
            model.addAttribute("recentOrders", recentOrders);

            // 세션 정보 추가
            model.addAttribute("userEmail", userEmail);
            model.addAttribute("userName", session.getAttribute("userName"));
            model.addAttribute("isAdmin", session.getAttribute("isAdmin"));

            System.out.println("마이페이지 접속 - 사용자: " + userEmail + ", 총 주문 수: " + totalOrders);

        } catch (Exception e) {
            System.err.println("마이페이지 로드 중 오류: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/?error=mypage_error";
        }

        return "user/mypageMain";
    }

    /**
     * 주문 내역 조회
     */
    @GetMapping("/orders")
    public String orderHistory(@RequestParam(value = "page", defaultValue = "0") int page,
                               @RequestParam(value = "status", required = false) String status,
                               @RequestParam(value = "startDate", required = false) String startDate,
                               @RequestParam(value = "endDate", required = false) String endDate,
                               HttpSession session, Model model) {
        try {
            // 로그인 확인
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                return "redirect:/login?redirect=/mypage/orders";
            }

            // 사용자 정보 조회
            Optional<UserEntity> userOpt = userService.findByEmail(userEmail);
            if (!userOpt.isPresent()) {
                return "redirect:/login?error=user_not_found";
            }

            UserEntity user = userOpt.get();

            // 주문 내역 조회 (필터링 적용)
            List<OrderEntity> orders = orderService.findOrdersByUser(user);

            // 상태별 필터링
            if (status != null && !status.isEmpty()) {
                orders = orders.stream()
                        .filter(order -> order.getOrderStatusCode().getOrderStatusCode().equals(status))
                        .toList();
            }

            // 날짜별 필터링
            if (startDate != null && endDate != null) {
                LocalDate start = LocalDate.parse(startDate);
                LocalDate end = LocalDate.parse(endDate);
                orders = orders.stream()
                        .filter(order -> {
                            LocalDate orderDate = order.getOrderDate();
                            return orderDate != null &&
                                    !orderDate.isBefore(start) &&
                                    !orderDate.isAfter(end);
                        })
                        .toList();
            }

            // 페이징 처리 (간단한 버전)
            int pageSize = 10;
            int totalOrders = orders.size();
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);

            int startIndex = page * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalOrders);

            List<OrderEntity> pagedOrders = orders.subList(startIndex, endIndex);

            // 모델에 데이터 추가
            model.addAttribute("orders", pagedOrders);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("totalOrders", totalOrders);
            model.addAttribute("selectedStatus", status);
            model.addAttribute("startDate", startDate);
            model.addAttribute("endDate", endDate);

            // 세션 정보 추가
            model.addAttribute("userEmail", userEmail);
            model.addAttribute("userName", session.getAttribute("userName"));
            model.addAttribute("isAdmin", session.getAttribute("isAdmin"));

            System.out.println("주문 내역 조회 - 사용자: " + userEmail + ", 주문 수: " + pagedOrders.size());

        } catch (Exception e) {
            System.err.println("주문 내역 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/mypage?error=order_history_error";
        }

        return "user/mypageOrders";
    }

    /**
     * 주문 상세 조회
     */
    @GetMapping("/orders/{orderId}")
    public String orderDetail(@PathVariable("orderId") Integer orderId,
                              HttpSession session, Model model) {

        System.out.println("=== 주문 상세 조회 시작 ===");
        System.out.println("주문 ID: " + orderId);

        try {
            // 로그인 확인
            String userEmail = (String) session.getAttribute("userEmail");
            System.out.println("사용자 이메일: " + userEmail);

            if (userEmail == null) {
                System.out.println("로그인되지 않음 - 로그인 페이지로 리다이렉트");
                return "redirect:/login";
            }

            // 주문 정보 조회
            System.out.println("주문 조회 시작...");
            Optional<OrderEntity> orderOpt = orderService.findOrderById(orderId);
            System.out.println("주문 조회 완료. 결과: " + (orderOpt.isPresent() ? "있음" : "없음"));

            if (!orderOpt.isPresent()) {
                System.err.println("주문을 찾을 수 없음: " + orderId);
                return "redirect:/mypage/orders?error=order_not_found";
            }

            OrderEntity order = orderOpt.get();
            System.out.println("주문 정보 확인: ID=" + order.getOrderId());

            // 사용자 정보 확인
            if (order.getUserId() == null) {
                System.err.println("주문에 사용자 정보가 없음");
                return "redirect:/mypage/orders?error=no_user_info";
            }

            String orderUserEmail = order.getUserId().getUserEmail();
            System.out.println("주문 사용자: " + orderUserEmail + ", 현재 사용자: " + userEmail);

            // 본인 주문인지 확인
            if (!orderUserEmail.equals(userEmail)) {
                System.err.println("권한 없음 - 접근 거부");
                return "redirect:/mypage/orders?error=access_denied";
            }

            // 취소 가능 여부 확인
            boolean canCancel = canCancelOrder(order);
            System.out.println("취소 가능 여부: " + canCancel);

            // 모델에 데이터 추가
            model.addAttribute("order", order);
            model.addAttribute("canCancel", canCancel);
            model.addAttribute("userEmail", userEmail);
            model.addAttribute("userName", session.getAttribute("userName"));
            model.addAttribute("isAdmin", session.getAttribute("isAdmin"));

            System.out.println("=== 주문 상세 조회 성공 ===");
            return "order/orderDetail";

        } catch (Exception e) {
            System.err.println("=== 주문 상세 조회 중 예외 발생 ===");
            System.err.println("예외 타입: " + e.getClass().getSimpleName());
            System.err.println("예외 메시지: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/mypage/orders?error=exception_occurred";
        }
    }

    /**
     * 주문 취소 요청
     */
    @PostMapping("/orders/{orderId}/cancel")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> cancelOrder(@PathVariable("orderId") Integer orderId,
                                                           HttpServletRequest request,
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

            // 주문 정보 조회
            Optional<OrderEntity> orderOpt = orderService.findOrderById(orderId);
            if (!orderOpt.isPresent()) {
                response.put("success", false);
                response.put("message", "주문 정보를 찾을 수 없습니다.");
                return ResponseEntity.ok(response);
            }

            OrderEntity order = orderOpt.get();

            // 권한 확인
            if (order.getUserId() == null || !order.getUserId().getUserEmail().equals(userEmail)) {
                response.put("success", false);
                response.put("message", "권한이 없습니다.");
                return ResponseEntity.ok(response);
            }

            // === 새로운 안전한 메서드 사용 ===
            if (!order.isCancellable()) {
                response.put("success", false);
                response.put("message", "해당 주문은 취소할 수 없습니다. (현재 상태: " + order.getOrderStatusCodeSafe() + ")");
                return ResponseEntity.ok(response);
            }

            // 주문 상태 업데이트
            boolean result = orderService.updateOrderStatus(orderId, "CANCELLED");

            if (result) {
                response.put("success", true);
                response.put("message", "주문이 취소되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "주문 취소 처리 중 오류가 발생했습니다.");
            }

        } catch (Exception e) {
            System.err.println("주문 취소 중 오류: " + e.getMessage());
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 개인정보 수정 페이지
     */
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        try {
            // 로그인 확인
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                return "redirect:/login?redirect=/mypage/profile";
            }

            // 사용자 정보 조회
            Optional<UserEntity> userOpt = userService.findByEmail(userEmail);
            if (!userOpt.isPresent()) {
                return "redirect:/login?error=user_not_found";
            }

            model.addAttribute("user", userOpt.get());
            model.addAttribute("userEmail", userEmail);
            model.addAttribute("userName", session.getAttribute("userName"));
            model.addAttribute("isAdmin", session.getAttribute("isAdmin"));

        } catch (Exception e) {
            System.err.println("개인정보 페이지 로드 중 오류: " + e.getMessage());
            return "redirect:/mypage?error=profile_error";
        }

        return "mypage/profile";
    }

    /**
     * 주문 취소 가능 여부 확인
     */
    private boolean canCancelOrder(OrderEntity order) {
        String status = order.getOrderStatusCode().getOrderStatusCode();

        // 이미 취소되었거나 완료된 주문은 취소 불가
        if ("CANCELLED".equals(status) || "COMPLETED".equals(status) || "DELIVERED".equals(status)) {
            return false;
        }

        // 배송 시작 전까지만 취소 가능
        return "PENDING".equals(status) || "PAYMENT_CONFIRMED".equals(status) || "PREPARING".equals(status);
    }
}