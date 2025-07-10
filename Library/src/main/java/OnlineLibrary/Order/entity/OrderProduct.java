package OnlineLibrary.Order.entity;

import OnlineLibrary.Products.entity.ProductEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name ="order_product")
@Getter @Setter
public class OrderProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_product_id")
    private Integer orderProductId;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private OrderEntity orderEntity;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private ProductEntity productEntity;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "unit_price") // 개인 상품 단가
    private Integer unitPrice;

    @Column(name = "payment_date")
    private LocalDate paymentDate;
}
