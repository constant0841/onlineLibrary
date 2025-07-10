package OnlineLibrary.Cart.controller;

import OnlineLibrary.Login.service.LoginSelectService;
import OnlineLibrary.Products.service.ProductService;
import OnlineLibrary.Products.entity.ProductEntity;
import OnlineLibrary.User.entity.UserEntity;
import OnlineLibrary.Cart.service.CartService;
import OnlineLibrary.Cart.entity.CartEntity;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType; // MediaType 임포트 추가
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final ProductService productService;
    private final LoginSelectService loginSelectService;
    private final CartService cartService; // CartService 주입

    @Autowired
    public CartController(ProductService productService, LoginSelectService loginSelectService, CartService cartService) {
        this.productService = productService;
        this.loginSelectService = loginSelectService;
        this.cartService = cartService;
    }

    // GET /cart 요청 처리
    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            model.addAttribute("message", "장바구니를 보려면 로그인이 필요합니다.");
            return "login"; // login.jsp 또는 login.html 로 리다이렉트
        }

        Optional<UserEntity> userOpt = loginSelectService.getUserByEmail(userEmail);
        if (!userOpt.isPresent()) {
            session.invalidate(); // 세션 무효화
            model.addAttribute("message", "사용자 정보를 찾을 수 없습니다. 다시 로그인해 주세요.");
            return "login";
        }
        UserEntity user = userOpt.get();
        // UserEntity의 ID가 Integer 타입이라면 Long.valueOf() 대신 그대로 사용
        Integer userId = user.getUserId(); // UserEntity의 ID가 Integer 타입이라고 가정

        List<CartEntity> cartItems = cartService.getCartItemsByUserId(userId);

        model.addAttribute("cartItems", cartItems);

        // JSP 파일의 실제 경로를 정확히 지정합니다.
        // 예를 들어 src/main/webapp/WEB-INF/views/product/cart.jsp 라면 "product/cart" 입니다.
        // 만약 src/main/webapp/WEB-INF/views/cart.jsp 라면 "cart" 입니다.
        return "product/cart"; // 혹은 "cart"
    }

    // POST /cart/add 요청 처리
    @PostMapping(value = "/add", produces = MediaType.APPLICATION_JSON_VALUE) // JSON 응답 명시
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCart(
            @RequestBody Map<String, Object> request,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                // HTTP 401 Unauthorized 상태 코드를 반환하는 것이 더 적절합니다.
                return ResponseEntity.status(401).body(response);
            }

            Optional<UserEntity> userOpt = loginSelectService.getUserByEmail(userEmail);
            if (!userOpt.isPresent()) {
                response.put("success", false);
                response.put("message", "사용자 정보를 찾을 수 없습니다.");
                // 사용자 정보 문제이므로 404 Not Found 또는 400 Bad Request
                return ResponseEntity.status(404).body(response);
            }
            UserEntity user = userOpt.get();
            Integer userId = user.getUserId();

            Integer productId = (Integer) request.get("productId");
            Integer quantity = (Integer) request.get("quantity");

            if (productId == null || quantity == null || quantity <= 0) {
                response.put("success", false);
                response.put("message", "잘못된 상품 정보 또는 수량입니다.");
                // 잘못된 요청 파라미터이므로 400 Bad Request
                return ResponseEntity.badRequest().body(response);
            }

            cartService.addOrUpdateCartItem(userId, productId, quantity);

            Long currentCartItemCount = cartService.getCartItemCount(userId);

            response.put("success", true);
            response.put("message", "장바구니에 상품이 추가되었습니다.");
            response.put("cartCount", currentCartItemCount);

            System.out.println("장바구니 추가 성공 - 사용자: " + userEmail + ", 상품ID: " + productId + ", 수량: " + quantity);

            return ResponseEntity.ok(response); // 200 OK

        } catch (Exception e) {
            System.err.println("장바구니 추가 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "장바구니 추가 중 오류가 발생했습니다: " + e.getMessage());
            // 서버 내부 오류이므로 500 Internal Server Error
            return ResponseEntity.status(500).body(response);
        }
    }

    // POST /cart/update 요청 처리: 장바구니 상품 수량 변경
    @PostMapping(value = "/update", produces = MediaType.APPLICATION_JSON_VALUE) // JSON 응답 명시
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCartItemQuantity(
            @RequestBody Map<String, Object> request,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response); // 401 Unauthorized
        }

        try {
            UserEntity user = loginSelectService.getUserByEmail(userEmail)
                    .orElseThrow(() -> new Exception("사용자 정보를 찾을 수 없습니다."));
            Integer userId = user.getUserId();

            Integer productId = (Integer) request.get("productId");
            Integer quantity = (Integer) request.get("quantity"); // 새로운 수량

            if (productId == null || quantity == null || quantity <= 0) {
                response.put("success", false);
                response.put("message", "잘못된 요청입니다: 상품ID 또는 수량 누락/잘못됨.");
                return ResponseEntity.badRequest().body(response); // 400 Bad Request
            }

            CartEntity updatedItem = cartService.updateCartItemQuantity(userId, productId, quantity);

            response.put("success", true); // 이 부분이 중요
            response.put("message", "수량이 변경되었습니다.");
            response.put("subtotal", updatedItem.getTotalPrice()); // 변경된 소계 반환

            System.out.println("장바구니 수량 변경 성공 - 사용자: " + userEmail + ", 상품ID: " + productId + ", 새 수량: " + quantity);

            return ResponseEntity.ok(response); // 200 OK

        } catch (Exception e) {
            System.err.println("장바구니 수량 변경 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false); // 이 부분이 중요
            response.put("message", "수량 변경 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(500).body(response); // 500 Internal Server Error
        }
    }

    // POST /cart/remove 요청 처리: 장바구니 상품 단일 삭제
    @PostMapping(value = "/remove", produces = MediaType.APPLICATION_JSON_VALUE) // JSON 응답 명시
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeCartItem(
            @RequestBody Map<String, Object> request,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response); // 401 Unauthorized
        }

        try {
            UserEntity user = loginSelectService.getUserByEmail(userEmail)
                    .orElseThrow(() -> new Exception("사용자 정보를 찾을 수 없습니다."));
            Integer userId = user.getUserId();

            Integer productId = (Integer) request.get("productId");

            if (productId == null) {
                response.put("success", false);
                response.put("message", "잘못된 요청입니다: 상품ID 누락.");
                return ResponseEntity.badRequest().body(response); // 400 Bad Request
            }

            cartService.removeCartItem(userId, productId);

            Long currentCartItemCount = cartService.getCartItemCount(userId);

            response.put("success", true); // 이 부분이 중요
            response.put("message", "상품이 장바구니에서 제거되었습니다.");
            response.put("cartCount", currentCartItemCount);

            System.out.println("장바구니 상품 삭제 성공 - 사용자: " + userEmail + ", 상품ID: " + productId);
            return ResponseEntity.ok(response); // 200 OK

        } catch (Exception e) {
            System.err.println("장바구니 상품 삭제 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false); // 이 부분이 중요
            response.put("message", "상품 삭제 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(500).body(response); // 500 Internal Server Error
        }
    }

    // POST /cart/clear 요청 처리: 장바구니 전체 비우기
    @PostMapping(value = "/clear", produces = MediaType.APPLICATION_JSON_VALUE) // JSON 응답 명시
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clearCart(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response); // 401 Unauthorized
        }

        try {
            UserEntity user = loginSelectService.getUserByEmail(userEmail)
                    .orElseThrow(() -> new Exception("사용자 정보를 찾을 수 없습니다."));
            Integer userId = user.getUserId();

            cartService.clearCart(userId);

            response.put("success", true); // 이 부분이 중요
            response.put("message", "장바구니가 비워졌습니다.");
            response.put("cartCount", 0L); // 장바구니가 비었으니 0 반환

            System.out.println("장바구니 전체 비우기 성공 - 사용자: " + userEmail);
            return ResponseEntity.ok(response); // 200 OK

        } catch (Exception e) {
            System.err.println("장바구니 전체 비우기 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false); // 이 부분이 중요
            response.put("message", "장바구니 비우기 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(500).body(response); // 500 Internal Server Error
        }
    }
}