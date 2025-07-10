package OnlineLibrary.Cart.repository;

import OnlineLibrary.Cart.entity.CartEntity;
import OnlineLibrary.Cart.entity.CartId; // CartId 임포트
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<CartEntity, CartId> { // CartId를 ID 타입으로 지정

    // 특정 사용자의 특정 상품에 대한 장바구니 항목을 찾는 메소드
    Optional<CartEntity> findByUserIdAndProductId(Integer userId, Integer productId);

    // 특정 사용자의 모든 장바구니 항목을 가져오는 메소드 (장바구니 페이지용)
    List<CartEntity> findByUserId(Integer userId);

    // 특정 사용자의 장바구니에 담긴 총 상품 개수를 세는 메소드
    Long countByUserId(Integer userId);

    // 특정 사용자의 모든 장바구니 항목을 삭제하는 메소드
    void deleteByUserId(Integer userId);
}