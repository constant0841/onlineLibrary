// DeliveryMethodRepository.java
package OnlineLibrary.Order.repository;

import OnlineLibrary.Order.entity.DeliveryMethod;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DeliveryMethodRepository extends JpaRepository<DeliveryMethod, String> {
    // 기본 CRUD 메서드들은 JpaRepository에서 제공

    // 추가 메서드가 필요하다면 여기에 정의
    // 예: Optional<DeliveryMethod> findByDeliveryMethodName(String methodName);
}