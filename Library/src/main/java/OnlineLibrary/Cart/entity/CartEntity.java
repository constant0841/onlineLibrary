package OnlineLibrary.Cart.entity;

import OnlineLibrary.Products.entity.ProductEntity;
import OnlineLibrary.User.entity.UserEntity;
import jakarta.persistence.*;

@Entity
@Table(name = "cart")
public class CartEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer userId;

    @OneToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

    @OneToOne
    @JoinColumn(name = "product_id")
    private ProductEntity productEntity;

    @Column(name = "product_count")
    private Integer productCount;

    @Column(name = "is_selected")
    private Boolean isSelected;

    @Column(name = "total_price") // 배송비 제외
    private Integer totalPrice;
}
