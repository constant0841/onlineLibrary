package OnlineLibrary.Cart.entity;

import java.io.Serializable;
import java.util.Objects;

// CartEntity의 복합 기본 키(Composite Primary Key) 클래스입니다.
// CartEntity의 @Id 필드들(userId, productId)과 동일한 타입과 이름으로 필드를 정의해야 합니다.
public class CartId implements Serializable {

    private Integer userId;    // CartEntity의 @Id user_id 필드와 매핑
    private Integer productId; // CartEntity의 @Id product_id 필드와 매핑

    // JPA에서 필요로 하는 기본 생성자
    public CartId() {
    }

    // 모든 필드를 포함하는 생성자 (편의를 위해 추가)
    public CartId(Integer userId, Integer productId) {
        this.userId = userId;
        this.productId = productId;
    }

    // 복합 키를 사용할 때 JPA가 객체를 비교하기 위해 반드시 필요한 메소드들입니다.
    // IDE의 자동 생성 기능을 사용하여 구현하는 것이 좋습니다.
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CartId cartId = (CartId) o;
        return Objects.equals(userId, cartId.userId) &&
                Objects.equals(productId, cartId.productId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, productId);
    }

    // (선택 사항) Getter/Setter도 추가할 수 있지만, 일반적으로 복합 키 클래스에서는 필수적이지 않습니다.
    // JPA가 필드 이름을 통해 매핑하기 때문입니다.
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
}