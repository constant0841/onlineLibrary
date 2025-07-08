package OnlineLibrary.Order.entity;

import OnlineLibrary.User.entity.UserEntity;
import jakarta.persistence.*;
import org.springframework.boot.autoconfigure.web.WebProperties;

import java.time.LocalDate;

@Entity
@Table(name = "order_table")
public class OrderEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Integer orderId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity userId;

    @ManyToOne
    @JoinColumn(name = "order_status_code")
    private OrderStatusCode orderStatusCode;

    @Column(name = "order_date")
    private LocalDate orderDate;

    @Column(name = "order_completed_date")
    private LocalDate orderCompletedDate;

    @Column(name = "total_price") // 배송비 미포함
    private Integer totalPrice;

    @Column(name = "payment_method", length = 20)
    private String paymentMethod;

    @ManyToOne
    @JoinColumn(name = "delivery_id")
    private Delivery delivery;


}
