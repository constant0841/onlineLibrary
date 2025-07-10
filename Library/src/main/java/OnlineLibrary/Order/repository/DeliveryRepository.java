package OnlineLibrary.Order.repository;

import OnlineLibrary.Order.entity.Delivery;
import OnlineLibrary.User.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface DeliveryRepository extends JpaRepository<Delivery, Integer> {

    /**
     * 사용자별 배송 조회
     */
    List<Delivery> findByUser(UserEntity user);

    /**
     * 배송 상태별 조회
     */
    @Query("SELECT d FROM Delivery d WHERE d.orderStatusCode.orderStatusCode = :statusCode ORDER BY d.deliveryStartDate DESC")
    List<Delivery> findByStatusCode(@Param("statusCode") String statusCode);

    /**
     * 배송 시작일 기준 조회
     */
    List<Delivery> findByDeliveryStartDateBetween(LocalDate startDate, LocalDate endDate);

    /**
     * 배송 완료일 기준 조회
     */
    List<Delivery> findByDeliveryEndDateBetween(LocalDate startDate, LocalDate endDate);

    /**
     * 배송 예정 목록 (배송 시작 전)
     */
    @Query("SELECT d FROM Delivery d WHERE d.deliveryStartDate IS NULL OR d.deliveryStartDate > :today ORDER BY d.deliveryId ASC")
    List<Delivery> findPendingDeliveries(@Param("today") LocalDate today);

    /**
     * 배송 중인 목록
     */
    @Query("SELECT d FROM Delivery d WHERE d.deliveryStartDate IS NOT NULL AND d.deliveryEndDate IS NULL ORDER BY d.deliveryStartDate ASC")
    List<Delivery> findInProgressDeliveries();

    /**
     * 배송 완료 목록
     */
    @Query("SELECT d FROM Delivery d WHERE d.deliveryEndDate IS NOT NULL ORDER BY d.deliveryEndDate DESC")
    List<Delivery> findCompletedDeliveries();

    /**
     * 특정 배송업체의 배송 조회
     */
    List<Delivery> findByDeliveryAgentName(String agentName);

    /**
     * 배송비별 조회
     */
    List<Delivery> findByDeliveryPrice(Integer deliveryPrice);

    /**
     * 무료 배송 조회
     */
    @Query("SELECT d FROM Delivery d WHERE d.deliveryPrice = 0 ORDER BY d.deliveryStartDate DESC")
    List<Delivery> findFreeDeliveries();

    /**
     * 지연 배송 조회 (예상 배송일 초과)
     */
    @Query("SELECT d FROM Delivery d WHERE d.deliveryStartDate IS NOT NULL AND d.deliveryEndDate IS NULL AND d.deliveryStartDate < :limitDate")
    List<Delivery> findDelayedDeliveries(@Param("limitDate") LocalDate limitDate);
}
