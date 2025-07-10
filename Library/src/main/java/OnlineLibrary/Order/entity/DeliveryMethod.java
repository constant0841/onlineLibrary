package OnlineLibrary.Order.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "delivery_method_code")
@Getter
@Setter
public class DeliveryMethod {
    @Id
    @Column(name = "delivery_method_code", length = 20)
    private String deliveryMethodCode;

    @Column(name = "delivery_method_name", length = 20)
    private String deliveryMethodName;
}
