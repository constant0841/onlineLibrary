package OnlineLibrary.Order.repository;

import OnlineLibrary.Order.entity.OrderStatusCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderStatusCodeRepository extends JpaRepository<OrderStatusCode, String> {

    /**
     * 모든 주문 상태 조회 (코드순 정렬)
     */
    List<OrderStatusCode> findAllByOrderByOrderStatusCodeAsc();

    /**
     * 상태명으로 검색
     */
    List<OrderStatusCode> findByOrderStatusContaining(String statusName);

    /**
     * 특정 상태 코드들 조회
     */
    List<OrderStatusCode> findByOrderStatusCodeIn(List<String> statusCodes);
}
