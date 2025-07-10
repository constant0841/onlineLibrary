package OnlineLibrary.Order.repository;

import OnlineLibrary.Order.entity.OrderEntity;
import OnlineLibrary.Order.entity.OrderProduct;
import OnlineLibrary.Products.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface OrderProductRepository extends JpaRepository<OrderProduct, Integer> {

    /**
     * 주문별 주문 상품 조회
     */
    List<OrderProduct> findByOrderEntity(OrderEntity order);

    /**
     * 상품별 주문 내역 조회
     */
    List<OrderProduct> findByProductEntity(ProductEntity product);

    /**
     * 특정 사용자의 구매한 상품 목록
     */
    @Query("SELECT op FROM OrderProduct op WHERE op.orderEntity.userId.userEmail = :userEmail ORDER BY op.paymentDate DESC")
    List<OrderProduct> findByUserEmail(@Param("userEmail") String userEmail);

    /**
     * 날짜별 판매 상품 조회
     */
    List<OrderProduct> findByPaymentDateBetween(LocalDate startDate, LocalDate endDate);

    /**
     * 상품별 총 판매량 조회
     */
    @Query("SELECT SUM(op.quantity) FROM OrderProduct op WHERE op.productEntity = :product")
    Integer getTotalSalesQuantityByProduct(@Param("product") ProductEntity product);

    /**
     * 베스트셀러 조회 (판매량 기준)
     */
    @Query("SELECT op.productEntity, SUM(op.quantity) as totalSales FROM OrderProduct op " +
            "GROUP BY op.productEntity ORDER BY totalSales DESC")
    List<Object[]> findBestSellingProducts();

    /**
     * 특정 기간 베스트셀러 조회
     */
    @Query("SELECT op.productEntity, SUM(op.quantity) as totalSales FROM OrderProduct op " +
            "WHERE op.paymentDate BETWEEN :startDate AND :endDate " +
            "GROUP BY op.productEntity ORDER BY totalSales DESC")
    List<Object[]> findBestSellingProductsByPeriod(@Param("startDate") LocalDate startDate,
                                                   @Param("endDate") LocalDate endDate);

    /**
     * 사용자가 구매한 특정 상품 확인 (리뷰 작성 권한 확인용)
     */
    @Query("SELECT CASE WHEN COUNT(op) > 0 THEN true ELSE false END FROM OrderProduct op " +
            "WHERE op.orderEntity.userId.userEmail = :userEmail AND op.productEntity.productId = :productId")
    boolean hasUserPurchasedProduct(@Param("userEmail") String userEmail, @Param("productId") Integer productId);

    /**
     * 상품별 일일 판매량 조회
     */
    @Query("SELECT op.paymentDate, SUM(op.quantity) FROM OrderProduct op " +
            "WHERE op.productEntity = :product " +
            "GROUP BY op.paymentDate ORDER BY op.paymentDate DESC")
    List<Object[]> getDailySalesByProduct(@Param("product") ProductEntity product);

    /**
     * 매출 통계 조회
     */
    @Query("SELECT DATE(op.paymentDate), SUM(op.quantity * op.unitPrice) " +
            "FROM OrderProduct op " +
            "WHERE op.paymentDate BETWEEN :startDate AND :endDate " +
            "GROUP BY DATE(op.paymentDate) ORDER BY DATE(op.paymentDate)")
    List<Object[]> getDailySalesRevenue(@Param("startDate") LocalDate startDate,
                                        @Param("endDate") LocalDate endDate);

    // OrderProductRepository.java에 추가할 메서드들

    /**
     * 주문 ID로 주문 상품 조회 (OrderService에서 사용)
     */
    @Query("SELECT op FROM OrderProduct op WHERE op.orderEntity.orderId = :orderId")
    List<OrderProduct> findByOrderEntity_OrderId(@Param("orderId") Integer orderId);

    /**
     * 주문 ID로 총 가격 계산
     */
    @Query("SELECT SUM(op.quantity * op.unitPrice) FROM OrderProduct op WHERE op.orderEntity.orderId = :orderId")
    Integer getTotalPriceByOrderId(@Param("orderId") Integer orderId);

    /**
     * 주문 ID로 총 수량 계산
     */
    @Query("SELECT SUM(op.quantity) FROM OrderProduct op WHERE op.orderEntity.orderId = :orderId")
    Integer getTotalQuantityByOrderId(@Param("orderId") Integer orderId);
}