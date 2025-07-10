package OnlineLibrary.Order.service;

import OnlineLibrary.Order.entity.*;
import OnlineLibrary.Order.repository.*;
import OnlineLibrary.User.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private DeliveryRepository deliveryRepository;

    @Autowired
    private OrderStatusCodeRepository orderStatusCodeRepository;

    @Autowired
    private DeliveryMethodRepository deliveryMethodRepository;

    @Autowired
    private OrderProductRepository orderProductRepository;

    /**
     * 주문 생성
     */
    public OrderEntity createOrder(UserEntity user) {
        try {
            // 1. 배송 정보 생성
            Delivery delivery = new Delivery();
            delivery.setUser(user);

            // 기본 배송 방법 설정 (예: "STANDARD")
            Optional<DeliveryMethod> deliveryMethodOpt = deliveryMethodRepository.findById("STANDARD");
            if (deliveryMethodOpt.isPresent()) {
                delivery.setDeliveryMethod(deliveryMethodOpt.get());
            }

            // 배송 요청사항 설정 (기본값)
            delivery.setDeliveryRequest("없음");

            // 배송비 계산 (20,000원 이상 무료배송, 미만 시 3,000원)
            // Integer totalPrice = calculateTotalPrice(); // 실제 상품 가격 계산 로직 필요
            delivery.setDeliveryPrice(3000); // 임시로 기본 배송비 설정

            // 2. 배송 상태 설정 (배송 대기)
            Optional<OrderStatusCode> deliveryStatusOpt = orderStatusCodeRepository.findById("DELIVERY_READY");
            if (deliveryStatusOpt.isPresent()) {
                delivery.setOrderStatusCode(deliveryStatusOpt.get());
            }

            delivery = deliveryRepository.save(delivery);

            // 3. 주문 생성
            OrderEntity order = new OrderEntity();
            order.setUserId(user);
            order.setOrderDate(LocalDate.now());
            order.setTotalPrice(0); // 실제 계산 로직 필요
            order.setPaymentMethod("카드결제");
            order.setDelivery(delivery);

            // 주문 상태 설정
            if (deliveryStatusOpt.isPresent()) {
                order.setOrderStatusCode(deliveryStatusOpt.get());
            }

            return orderRepository.save(order);

        } catch (Exception e) {
            System.err.println("주문 생성 중 오류 발생: " + e.getMessage());
            throw new RuntimeException("주문 생성에 실패했습니다.", e);
        }
    }

    /**
     * 배송 정보 업데이트
     */
    public boolean updateDeliveryInfo(Integer deliveryId, String deliveryRequest, Integer deliveryPrice) {
        try {
            Optional<Delivery> deliveryOpt = deliveryRepository.findById(deliveryId);
            if (deliveryOpt.isPresent()) {
                Delivery delivery = deliveryOpt.get();

                // 배송 요청사항 업데이트
                if (deliveryRequest != null) {
                    delivery.setDeliveryRequest(deliveryRequest);
                }

                // 배송비 업데이트
                if (deliveryPrice != null) {
                    delivery.setDeliveryPrice(deliveryPrice);
                }

                deliveryRepository.save(delivery);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("배송 정보 업데이트 중 오류 발생: " + e.getMessage());
            return false;
        }
    }

    /**
     * 배송 담당자 정보 업데이트
     */
    public boolean updateDeliveryAgent(Integer deliveryId, String agentName, String agentPhone) {
        try {
            Optional<Delivery> deliveryOpt = deliveryRepository.findById(deliveryId);
            if (deliveryOpt.isPresent()) {
                Delivery delivery = deliveryOpt.get();

                if (agentName != null) {
                    delivery.setDeliveryAgentName(agentName);
                }

                if (agentPhone != null) {
                    delivery.setDeliveryAgentPhone(agentPhone);
                }

                deliveryRepository.save(delivery);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("배송 담당자 정보 업데이트 중 오류 발생: " + e.getMessage());
            return false;
        }
    }

    /**
     * 주문 상태 업데이트
     */
    public boolean updateOrderStatus(Integer orderId, String statusCode) {
        try {
            Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
            Optional<OrderStatusCode> statusOpt = orderStatusCodeRepository.findById(statusCode);

            if (orderOpt.isPresent() && statusOpt.isPresent()) {
                OrderEntity order = orderOpt.get();
                OrderStatusCode status = statusOpt.get();

                order.setOrderStatusCode(status);

                // 주문 완료 날짜 설정 (상태가 완료인 경우)
                if ("COMPLETED".equals(statusCode)) {
                    order.setOrderCompletedDate(LocalDate.now());
                }

                orderRepository.save(order);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("주문 상태 업데이트 중 오류 발생: " + e.getMessage());
            return false;
        }
    }

    /**
     * 주문 조회
     */
    public Optional<OrderEntity> findOrderById(Integer orderId) {
        try {
            return orderRepository.findById(orderId);
        } catch (Exception e) {
            System.err.println("주문 조회 중 오류 발생: " + e.getMessage());
            return Optional.empty();
        }
    }

    /**
     * 배송 정보 조회
     */
    public Optional<Delivery> findDeliveryById(Integer deliveryId) {
        try {
            return deliveryRepository.findById(deliveryId);
        } catch (Exception e) {
            System.err.println("배송 정보 조회 중 오류 발생: " + e.getMessage());
            return Optional.empty();
        }
    }

    /**
     * 주문 상품 추가
     */
    public boolean addOrderProduct(Integer orderId, OrderProduct orderProduct) {
        try {
            Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
            if (orderOpt.isPresent()) {
                OrderEntity order = orderOpt.get();
                orderProduct.setOrderEntity(order);
                orderProduct.setPaymentDate(LocalDate.now());

                orderProductRepository.save(orderProduct);

                // 주문 총액 재계산
                updateOrderTotalPrice(orderId);

                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("주문 상품 추가 중 오류 발생: " + e.getMessage());
            return false;
        }
    }

    /**
     * 주문 총 가격 업데이트
     */
    public boolean updateOrderTotalPrice(Integer orderId) {
        try {
            Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
            if (orderOpt.isPresent()) {
                OrderEntity order = orderOpt.get();

                // 주문 상품들의 총 가격 계산
                Integer totalPrice = calculateOrderTotalPrice(orderId);
                order.setTotalPrice(totalPrice);

                // 배송비 재계산
                if (order.getDelivery() != null) {
                    Integer deliveryPrice = calculateDeliveryPrice(totalPrice);
                    order.getDelivery().setDeliveryPrice(deliveryPrice);
                    deliveryRepository.save(order.getDelivery());
                }

                orderRepository.save(order);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("주문 총 가격 업데이트 중 오류 발생: " + e.getMessage());
            return false;
        }
    }

    /**
     * 주문별 총 가격 계산
     */
    private Integer calculateOrderTotalPrice(Integer orderId) {
        try {
            Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
            if (orderOpt.isPresent()) {
                OrderEntity order = orderOpt.get();
                List<OrderProduct> orderProducts = orderProductRepository.findByOrderEntity(order);
                return orderProducts.stream()
                        .mapToInt(op -> op.getQuantity() * op.getUnitPrice())
                        .sum();
            }
            return 0;
        } catch (Exception e) {
            System.err.println("주문 총 가격 계산 중 오류 발생: " + e.getMessage());
            return 0;
        }
    }

    /**
     * 배송비 계산
     */
    public Integer calculateDeliveryPrice(Integer totalPrice) {
        try {
            // 20,000원 이상 무료배송, 미만 시 3,000원
            return totalPrice >= 20000 ? 0 : 3000;
        } catch (Exception e) {
            System.err.println("배송비 계산 중 오류 발생: " + e.getMessage());
            return 3000; // 기본 배송비
        }
    }

    /**
     * 사용자별 주문 내역 조회
     */
    public List<OrderEntity> findOrdersByUser(UserEntity user) {
        try {
            return orderRepository.findByUserIdOrderByOrderDateDesc(user);
        } catch (Exception e) {
            System.err.println("사용자 주문 내역 조회 중 오류 발생: " + e.getMessage());
            return List.of();
        }
    }

    /**
     * 주문 상태별 주문 조회
     */
    public List<OrderEntity> findOrdersByStatus(String statusCode) {
        try {
            return orderRepository.findByOrderStatusCodeOrderByOrderDateDesc(statusCode);
        } catch (Exception e) {
            System.err.println("상태별 주문 조회 중 오류 발생: " + e.getMessage());
            return List.of();
        }
    }

    /**
     * 주문 취소
     */
    public boolean cancelOrder(Integer orderId) {
        try {
            Optional<OrderEntity> orderOpt = orderRepository.findById(orderId);
            if (orderOpt.isPresent()) {
                OrderEntity order = orderOpt.get();

                // 취소 가능 상태 확인
                String currentStatus = order.getOrderStatusCode().getOrderStatusCode();
                if (!"CANCELLED".equals(currentStatus) && !"COMPLETED".equals(currentStatus)) {
                    // 주문 상태를 취소로 변경
                    Optional<OrderStatusCode> cancelStatusOpt = orderStatusCodeRepository.findById("CANCELLED");
                    if (cancelStatusOpt.isPresent()) {
                        order.setOrderStatusCode(cancelStatusOpt.get());
                        orderRepository.save(order);
                        return true;
                    }
                }
            }
            return false;
        } catch (Exception e) {
            System.err.println("주문 취소 중 오류 발생: " + e.getMessage());
            return false;
        }
    }

    /**
     * 복잡한 주문 생성 (Controller에서 사용)
     */
    public OrderEntity createOrder(UserEntity user, List<Map<String, Object>> items,
                                   String deliveryAddress, String deliveryRequest, String paymentMethod) {
        try {
            // 기본 주문 생성
            OrderEntity order = createOrder(user);

            // 주문 상품들 추가 및 총액 계산
            Integer totalPrice = 0;
            for (Map<String, Object> item : items) {
                Integer productId = (Integer) item.get("productId");
                Integer quantity = (Integer) item.get("quantity");
                Integer unitPrice = (Integer) item.get("unitPrice");

                // OrderProduct 생성 로직 (실제 구현 필요)
                // OrderProduct orderProduct = new OrderProduct();
                // 여기서 실제 상품 추가 로직 구현

                totalPrice += quantity * unitPrice;
            }

            // 주문 총액 업데이트
            order.setTotalPrice(totalPrice);
            order.setPaymentMethod(paymentMethod);

            // 배송 정보 업데이트
            if (order.getDelivery() != null) {
                updateDeliveryInfo(order.getDelivery().getDeliveryId(), deliveryRequest,
                        calculateDeliveryPrice(totalPrice));
            }

            return orderRepository.save(order);

        } catch (Exception e) {
            System.err.println("복잡한 주문 생성 중 오류 발생: " + e.getMessage());
            return null;
        }
    }
}