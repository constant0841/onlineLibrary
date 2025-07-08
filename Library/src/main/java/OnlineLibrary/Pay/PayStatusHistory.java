package OnlineLibrary.Pay;

import OnlineLibrary.Order.entity.OrderEntity;
import jakarta.persistence.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDate;

@Entity
@Table(name = "pay_status_history")
public class PayStatusHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "pay_status_history_id")
    private Integer payStatusHistoryId;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private OrderEntity orderEntity;

    @ManyToOne
    @JoinColumn(name = "pay_status_code")
    private PayStatusCode payStatusCode;

    @Column(name = "status_change_reason", columnDefinition = "TEXT")
    private String statusChangeReason;

    @Column(name = "status_change_at")
    private LocalDate statusChangeAt;
}
