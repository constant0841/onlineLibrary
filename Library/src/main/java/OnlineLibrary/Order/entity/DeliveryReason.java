package OnlineLibrary.Order.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "delivery_reason")
@Getter @Setter
public class DeliveryReason {
    @Id
    @Column(name = "delivery_reason_code", length = 20)
    private String deliveryReasonCode;

    @Column(name = "delivery_reason_name", length = 20)
    private String deliveryReasonName;

}
