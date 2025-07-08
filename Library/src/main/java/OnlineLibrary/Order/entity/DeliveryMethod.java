package OnlineLibrary.Order.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "delivery_method_code")
public class DeliveryMethod {
    @Id
    @Column(name = "delivery_method_code", length = 20)
    private String deliveryMethodCode;

    @Column(name = "delivery_method_name", length = 20)
    private String deliveryMethodName;
}
