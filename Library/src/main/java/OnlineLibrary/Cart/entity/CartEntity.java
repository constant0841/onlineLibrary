package OnlineLibrary.Cart.entity;

import OnlineLibrary.Products.entity.ProductEntity;
import OnlineLibrary.User.entity.UserEntity;
import jakarta.persistence.*; // Spring Boot 3.x 버전에서는 'jakarta.persistence.*'를 사용합니다.

@Entity
@Table(name = "cart") // MySQL의 'cart' 테이블과 매핑됩니다.
@IdClass(CartId.class) // 복합 기본 키 클래스를 지정합니다.
public class CartEntity {
    // 복합 기본 키의 첫 번째 부분: user_id
    @Id
    @Column(name = "user_id")
    private Integer userId; // UserEntity의 ID 타입(Integer)과 일치해야 합니다.

    // 복합 기본 키의 두 번째 부분: product_id
    @Id
    @Column(name = "product_id")
    private Integer productId; // ProductEntity의 ID 타입(Integer)과 일치해야 합니다.

    // user_id를 참조하는 UserEntity와의 다대일(ManyToOne) 관계 설정
    // insertable = false, updatable = false는 이 컬럼이 이 엔티티에 의해 삽입/업데이트되지 않음을 의미합니다.
    // 이는 @Id로도 사용되고 @JoinColumn으로도 사용될 때 주로 사용합니다.
    @ManyToOne
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private UserEntity user; // UserEntity 필드 추가 (필수적인 매핑)

    // product_id를 참조하는 ProductEntity와의 다대일(ManyToOne) 관계 설정
    @ManyToOne
    @JoinColumn(name = "product_id", insertable = false, updatable = false)
    private ProductEntity product; // ProductEntity 필드 추가 (필수적인 매핑)

    @Column(name = "product_count")
    private Integer productCount; // 상품 수량 (DB 컬럼명과 일치)

    @Column(name = "is_selected")
    private Boolean isSelected; // 장바구니에서 선택된 상태 여부 (DB 컬럼명과 일치)

    @Column(name = "total_price")
    private Integer totalPrice; // 총 가격 (DB 컬럼명과 일치, Integer로 가정)
    // 실제 서비스에서는 BigDecimal 또는 Double 사용을 권장합니다.
    // Integer로 가격을 다루는 것은 소수점 이하의 금액이 없을 때 적합합니다.

    // --- Getter와 Setter 메소드 ---
    // (롬복(Lombok)을 사용한다면 @Getter, @Setter 어노테이션으로 대체 가능합니다.)

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public UserEntity getUser() {
        return user;
    }

    public void setUser(UserEntity user) {
        this.user = user;
    }

    public ProductEntity getProduct() {
        return product;
    }

    public void setProduct(ProductEntity product) {
        this.product = product;
    }

    public Integer getProductCount() {
        return productCount;
    }

    public void setProductCount(Integer productCount) {
        this.productCount = productCount;
    }

    public Boolean getIsSelected() {
        return isSelected;
    }

    public void setIsSelected(Boolean selected) {
        isSelected = selected;
    }

    public Integer getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Integer totalPrice) {
        this.totalPrice = totalPrice;
    }
}