package OnlineLibrary.Order.controller;

import OnlineLibrary.Order.entity.OrderEntity;
import OnlineLibrary.Order.service.OrderService;
import OnlineLibrary.Products.entity.ProductEntity;
import OnlineLibrary.Products.service.ProductService;
import OnlineLibrary.User.entity.UserEntity;
import OnlineLibrary.User.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.sql.Date;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    /**
     * 장바구니에서 주문서 작성 페이지로 이동
     */
    @PostMapping("/checkout")
    public String checkout(@RequestParam Map<String, String> params,
                           HttpSession session, Model model) {
        try {
            // 로그인 확인
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                return "redirect:/login?redirect=/cart";
            }

            // 사용자 정보 조회
            Optional<UserEntity> userOpt = userService.findByEmail(userEmail);
            if (!userOpt.isPresent()) {
                return "redirect:/cart?error=user_not_found";
            }

            UserEntity user = userOpt.get();

            // 기존 cart.jsp에서 오는 items[index] 형태의 데이터 파싱
            List<OrderItem> orderItems = new ArrayList<>();
            int totalPrice = 0;
            int index = 0;

            // items[0].productId, items[0].quantity 형태로 파싱
            while (params.containsKey("items[" + index + "].productId")) {
                try {
                    String productIdStr = params.get("items[" + index + "].productId");
                    String quantityStr = params.get("items[" + index + "].quantity");

                    if (productIdStr == null || quantityStr == null) {
                        index++;
                        continue;
                    }

                    Integer productId = Integer.valueOf(productIdStr);
                    Integer quantity = Integer.valueOf(quantityStr);

                    // 상품 정보 조회 (ProductService 메서드명 확인 필요)
                    Optional<ProductEntity> productOpt = productService.getProductById(productId);
                    if (!productOpt.isPresent()) {
                        index++;
                        continue;
                    }

                    ProductEntity product = productOpt.get();

                    // 재고 확인 (필드명 확인 필요)
                    if (product.getStockQuantity() != null && product.getStockQuantity() < quantity) {
                        model.addAttribute("error", product.getProductName() + "의 재고가 부족합니다.");
                        return "redirect:/cart";
                    }

                    OrderItem orderItem = new OrderItem();
                    orderItem.setProduct(product);
                    orderItem.setQuantity(quantity);
                    orderItem.setSubtotal(product.getProductPrice() * quantity);

                    orderItems.add(orderItem);
                    totalPrice += orderItem.getSubtotal();

                } catch (Exception e) {
                    System.err.println("주문 아이템 파싱 오류 (index " + index + "): " + e.getMessage());
                }
                index++;
            }

            if (orderItems.size() == 0) {
                return "redirect:/cart?error=no_items";
            }

            // 배송비 계산
            int shippingFee = totalPrice >= 20000 ? 0 : 3000;
            int finalTotal = totalPrice + shippingFee;

            // 모델에 데이터 추가
            model.addAttribute("user", user);
            model.addAttribute("orderItems", orderItems);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("shippingFee", shippingFee);
            model.addAttribute("finalTotal", finalTotal);
            model.addAttribute("itemCount", orderItems.size());

            // 세션 정보 추가
            model.addAttribute("userEmail", userEmail);
            model.addAttribute("userName", session.getAttribute("userName"));
            model.addAttribute("isAdmin", session.getAttribute("isAdmin"));

            System.out.println("주문서 작성 페이지 이동 - 사용자: " + userEmail + ", 상품 수: " + orderItems.size());

        } catch (Exception e) {
            System.err.println("주문서 작성 중 오류: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/cart?error=checkout_error";
        }

        return "order/orderCheckout";
    }

    /**
     * 바로 구매
     */
    @GetMapping("/direct")
    public String directOrder(@RequestParam("productId") Integer productId,
                              @RequestParam("quantity") Integer quantity,
                              HttpSession session, Model model) {
        try {
            // 로그인 확인
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                return "redirect:/login?redirect=/product/" + productId;
            }

            // 사용자 정보 조회
            Optional<UserEntity> userOpt = userService.findByEmail(userEmail);
            if (!userOpt.isPresent()) {
                return "redirect:/product/" + productId + "?error=user_not_found";
            }

            UserEntity user = userOpt.get();

            // 상품 정보 조회
            Optional<ProductEntity> productOpt = productService.getProductById(productId);
            if (!productOpt.isPresent()) {
                return "redirect:/?error=product_not_found";
            }

            ProductEntity product = productOpt.get();

            // 재고 확인
            if (product.getStockQuantity() != null && product.getStockQuantity() < quantity) {
                return "redirect:/product/" + productId + "?error=insufficient_stock";
            }

            // 주문 아이템 생성
            List<OrderItem> orderItems = new ArrayList<>();
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(product);
            orderItem.setQuantity(quantity);
            orderItem.setSubtotal(product.getProductPrice() * quantity);
            orderItems.add(orderItem);

            int totalPrice = orderItem.getSubtotal();
            int shippingFee = totalPrice >= 20000 ? 0 : 3000;
            int finalTotal = totalPrice + shippingFee;

            // 모델에 데이터 추가
            model.addAttribute("user", user);
            model.addAttribute("orderItems", orderItems);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("shippingFee", shippingFee);
            model.addAttribute("finalTotal", finalTotal);
            model.addAttribute("itemCount", 1);

            // 세션 정보 추가
            model.addAttribute("userEmail", userEmail);
            model.addAttribute("userName", session.getAttribute("userName"));
            model.addAttribute("isAdmin", session.getAttribute("isAdmin"));

            System.out.println("바로 구매 주문서 - 사용자: " + userEmail + ", 상품: " + product.getProductName());

        } catch (Exception e) {
            System.err.println("바로 구매 처리 중 오류: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/product/" + productId + "?error=order_error";
        }

        return "order/orderCheckout";
    }

    /**
     * 주문 완료 처리
     */
    @PostMapping("/complete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> completeOrder(
            @RequestBody Map<String, Object> orderRequest,
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

            // 사용자 정보 조회
            Optional<UserEntity> userOpt = userService.findByEmail(userEmail);
            if (!userOpt.isPresent()) {
                response.put("success", false);
                response.put("message", "사용자 정보를 찾을 수 없습니다.");
                return ResponseEntity.ok(response);
            }

            // 주문 정보 추출
            String deliveryAddress = (String) orderRequest.get("deliveryAddress");
            String deliveryRequest = (String) orderRequest.get("deliveryRequest");
            String paymentMethod = (String) orderRequest.get("paymentMethod");
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> items = (List<Map<String, Object>>) orderRequest.get("items");

            if (items == null || items.size() == 0) {
                response.put("success", false);
                response.put("message", "주문 상품이 없습니다.");
                return ResponseEntity.ok(response);
            }

            // 주문 생성
            OrderEntity order = orderService.createOrder(userOpt.get());

            if (order != null) {
                // 배송 정보 업데이트
                if (order.getDelivery() != null) {
                    orderService.updateDeliveryInfo(
                            order.getDelivery().getDeliveryId(),
                            deliveryRequest,
                            orderService.calculateDeliveryPrice(order.getTotalPrice())
                    );
                }

                // 장바구니에서 주문한 상품들 제거
                removeOrderedItemsFromCart(session, items);

                response.put("success", true);
                response.put("message", "주문이 완료되었습니다.");
                response.put("orderId", order.getOrderId());
            } else {
                response.put("success", false);
                response.put("message", "주문 처리 중 오류가 발생했습니다.");
            }

            System.out.println("주문 완료 - 사용자: " + userEmail + ", 주문ID: " + (order != null ? order.getOrderId() : "null"));

        } catch (Exception e) {
            System.err.println("주문 완료 처리 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "주문 처리 중 오류가 발생했습니다.");
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 주문 완료 페이지
     */
    @GetMapping("/success/{orderId}")
    public String orderSuccess(@PathVariable("orderId") Integer orderId,
                               HttpSession session, Model model) {
        try {
            // 로그인 확인
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail == null) {
                return "redirect:/login";
            }

            // 주문 정보 조회
            Optional<OrderEntity> orderOpt = orderService.findOrderById(orderId);
            if (!orderOpt.isPresent()) {
                return "redirect:/?error=order_not_found";
            }

            OrderEntity order = orderOpt.get();

            // 본인 주문인지 확인
            if (!order.getUserId().getUserEmail().equals(userEmail)) {
                return "redirect:/?error=access_denied";
            }

            model.addAttribute("order", order);

            // LocalDate를 Date로 변환하여 JSP에서 사용 가능하도록 함
            if (order.getOrderDate() != null) {
                model.addAttribute("orderDate", Date.valueOf(order.getOrderDate()));
            }
            if (order.getOrderCompletedDate() != null) {
                model.addAttribute("orderCompletedDate", Date.valueOf(order.getOrderCompletedDate()));
            }

            model.addAttribute("userEmail", userEmail);
            model.addAttribute("userName", session.getAttribute("userName"));
            model.addAttribute("isAdmin", session.getAttribute("isAdmin"));

        } catch (Exception e) {
            System.err.println("주문 완료 페이지 오류: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/?error=page_error";
        }

        return "order/orderSuccess";
    }

    /**
     * 장바구니에서 주문한 상품들 제거
     */
    @SuppressWarnings("unchecked")
    private void removeOrderedItemsFromCart(HttpSession session, List<Map<String, Object>> items) {
        try {
            Object cartObj = session.getAttribute("cart");
            if (cartObj instanceof Map) {
                Map<Integer, Integer> cartItems = (Map<Integer, Integer>) cartObj;

                for (Map<String, Object> item : items) {
                    Integer productId = (Integer) item.get("productId");
                    if (productId != null) {
                        cartItems.remove(productId);
                    }
                }

                session.setAttribute("cart", cartItems);
            }
        } catch (Exception e) {
            System.err.println("장바구니 상품 제거 중 오류: " + e.getMessage());
        }
    }

    /**
     * 주문 아이템 클래스
     */
    public static class OrderItem {
        private ProductEntity product;
        private Integer quantity;
        private Integer subtotal;

        // Getters and Setters
        public ProductEntity getProduct() { return product; }
        public void setProduct(ProductEntity product) { this.product = product; }

        public Integer getQuantity() { return quantity; }
        public void setQuantity(Integer quantity) { this.quantity = quantity; }

        public Integer getSubtotal() { return subtotal; }
        public void setSubtotal(Integer subtotal) { this.subtotal = subtotal; }
    }
}