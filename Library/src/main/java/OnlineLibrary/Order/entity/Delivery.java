package OnlineLibrary.Order.entity;

import OnlineLibrary.User.entity.UserEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "delivery")
@Getter @Setter
public class Delivery {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "delivery_id")
    private Integer deliveryId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;

    @ManyToOne
    @JoinColumn(name = "delivery_method_code")
    private DeliveryMethod deliveryMethod;

    @ManyToOne
    @JoinColumn(name = "order_status_code")
    private OrderStatusCode orderStatusCode;

    @Column(name = "delivery_start_date")
    private LocalDate deliveryStartDate;

    @Column(name = "delivery_end_date")
    private LocalDate deliveryEndDate;

    @ManyToOne
    @JoinColumn(name = "delivery_reason_code")
    private DeliveryReason deliveryReason;

    @Column(name = "delivery_agent_name", length = 20)
    private String deliveryAgentName;

    @Column(name = "delivery_agent_phone", length = 20)
    private String deliveryAgentPhone;

    @Column(name = "delivery_request", columnDefinition = "TEXT")
    private String deliveryRequest;

    @Column(name = "delivery_price")
    private Integer deliveryPrice;
}
