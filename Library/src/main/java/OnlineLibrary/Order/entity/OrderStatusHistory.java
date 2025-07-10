package OnlineLibrary.Order.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "order_status_history")
@Getter @Setter
public class OrderStatusHistory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_status_history_id")
    private Integer orderStatusHistoryId;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private OrderEntity orderEntity;

    @ManyToOne
    @JoinColumn(name = "order_status_code")
    private OrderStatusCode orderStatusCode;

    @Column(name = "changed_at")
    private LocalDate changeAt;

    @Column(name = "change_reason", columnDefinition = "TEXT")
    private String changeReason;
}
