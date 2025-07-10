package OnlineLibrary.Order.repository;

import OnlineLibrary.Order.entity.OrderStatusHistory;
import OnlineLibrary.Order.entity.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface OrderStatusHistoryRepository extends JpaRepository<OrderStatusHistory, Integer> {

    /**
     * 주문별 상태 변경 이력 조회
     */
    List<OrderStatusHistory> findByOrderEntityOrderByChangeAtDesc(OrderEntity order);

    /**
     * 특정 날짜의 상태 변경 이력
     */
    List<OrderStatusHistory> findByChangeAtBetween(LocalDate startDate, LocalDate endDate);

    /**
     * 특정 상태로 변경된 이력 조회
     */
    @Query("SELECT osh FROM OrderStatusHistory osh WHERE osh.orderStatusCode.orderStatusCode = :statusCode ORDER BY osh.changeAt DESC")
    List<OrderStatusHistory> findByStatusCode(@Param("statusCode") String statusCode);

    /**
     * 최근 상태 변경 이력 조회
     */
    List<OrderStatusHistory> findTop50ByOrderByChangeAtDesc();
}