package OnlineLibrary.Order.repository;

import OnlineLibrary.Order.entity.OrderEntity;
import OnlineLibrary.User.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {

    /**
     * 사용자별 주문 목록 조회 (최신순)
     */
    List<OrderEntity> findByUserIdOrderByOrderDateDesc(UserEntity user);

    /**
     * 사용자 이메일별 주문 목록 조회 (최신순)
     */
    @Query("SELECT o FROM OrderEntity o WHERE o.userId.userEmail = :userEmail ORDER BY o.orderDate DESC")
    List<OrderEntity> findByUserIdUserEmailOrderByOrderDateDesc(@Param("userEmail") String userEmail);

    /**
     * 주문 상태별 조회
     */
    @Query("SELECT o FROM OrderEntity o WHERE o.orderStatusCode.orderStatusCode = :statusCode ORDER BY o.orderDate DESC")
    List<OrderEntity> findByOrderStatusCodeOrderByOrderDateDesc(@Param("statusCode") String statusCode);

    /**
     * 날짜 범위별 주문 조회
     */
    List<OrderEntity> findByOrderDateBetweenOrderByOrderDateDesc(LocalDate startDate, LocalDate endDate);

    /**
     * 사용자별 특정 기간 주문 조회
     */
    @Query("SELECT o FROM OrderEntity o WHERE o.userId = :user AND o.orderDate BETWEEN :startDate AND :endDate ORDER BY o.orderDate DESC")
    List<OrderEntity> findByUserAndDateRange(@Param("user") UserEntity user,
                                             @Param("startDate") LocalDate startDate,
                                             @Param("endDate") LocalDate endDate);

    /**
     * 총 주문 금액별 조회
     */
    List<OrderEntity> findByTotalPriceGreaterThanEqualOrderByOrderDateDesc(Integer minAmount);

    /**
     * 결제 방법별 조회
     */
    List<OrderEntity> findByPaymentMethodOrderByOrderDateDesc(String paymentMethod);

    /**
     * 오늘 주문 조회
     */
    @Query("SELECT o FROM OrderEntity o WHERE o.orderDate = :today ORDER BY o.orderId DESC")
    List<OrderEntity> findTodayOrders(@Param("today") LocalDate today);

    /**
     * 월별 주문 통계
     */
    @Query("SELECT YEAR(o.orderDate), MONTH(o.orderDate), COUNT(o), SUM(o.totalPrice) " +
            "FROM OrderEntity o " +
            "GROUP BY YEAR(o.orderDate), MONTH(o.orderDate) " +
            "ORDER BY YEAR(o.orderDate) DESC, MONTH(o.orderDate) DESC")
    List<Object[]> getMonthlyOrderStats();

    /**
     * 사용자별 총 주문 금액
     */
    @Query("SELECT SUM(o.totalPrice) FROM OrderEntity o WHERE o.userId = :user")
    Integer getTotalOrderAmountByUser(@Param("user") UserEntity user);

    /**
     * 최근 주문 조회 (관리자용)
     */
    List<OrderEntity> findTop20ByOrderByOrderDateDesc();
}