package OnlineLibrary.Order.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "order_status_code")
public class OrderStatusCode {
    @Id
    @Column(name = "order_status_code", length = 20)
    private String orderStatusCode;

    @Column(name = "order_status", length = 20)
    private String orderStatus;
}
