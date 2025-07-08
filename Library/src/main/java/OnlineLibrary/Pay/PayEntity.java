package OnlineLibrary.Pay;

import OnlineLibrary.Order.entity.OrderEntity;
import OnlineLibrary.User.entity.UserEntity;
import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "pay")
public class PayEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "pay_id")
    private Integer payId;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private OrderEntity orderEntity;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity userEntity;

    @ManyToOne
    @JoinColumn(name = "pay_method_code")
    private PayMethodCode payMethodCode;

    @Column(name = "pay_amount")
    private Integer payAmount;

    @Column(name = "pay_agency", length = 20)
    private String payAgency;

    @ManyToOne
    @JoinColumn(name = "pay_status_code")
    private PayStatusCode payStatusCode;

    @Column(name = "pay_fail_reason", length = 20)
    private String payFailReason;

    @Column(name = "pay_request_at")
    private LocalDate payRequestAt;

    @Column(name = "pay_approved_at")
    private LocalDate payApprovedAt;

    @Column(name = "is_cancelable")
    private Boolean isCancelable;

    @Column(name = "is_refundable")
    private Boolean isRefundable;
}
