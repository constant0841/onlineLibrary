package OnlineLibrary.Order.entity;

import OnlineLibrary.User.entity.UserEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.autoconfigure.web.WebProperties;

import java.time.LocalDate;

@Entity
@Table(name = "order_table")
@Getter @Setter
public class OrderEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Integer orderId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private UserEntity userId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "order_status_code")
    private OrderStatusCode orderStatusCode;

    @Column(name = "order_date")
    private LocalDate orderDate;

    @Column(name = "order_completed_date")
    private LocalDate orderCompletedDate;

    @Column(name = "total_price")
    private Integer totalPrice;

    @Column(name = "payment_method", length = 20)
    private String paymentMethod;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "delivery_id")
    private Delivery delivery;

    // === 기본값 처리 메서드 추가 ===

    /**
     * OrderStatusCode가 null일 때 기본 상태 반환
     */
    public String getOrderStatusCodeSafe() {
        if (orderStatusCode != null) {
            return orderStatusCode.getOrderStatusCode();
        }
        return "PENDING"; // 기본값
    }

    /**
     * 취소 가능 여부 확인 (null 안전)
     */
    public boolean isCancellable() {
        String status = getOrderStatusCodeSafe();

        // 취소 불가능한 상태들
        if ("CANCELLED".equals(status) ||
                "COMPLETED".equals(status) ||
                "DELIVERED".equals(status)) {
            return false;
        }

        // 기본적으로 취소 가능
        return true;
    }
}
