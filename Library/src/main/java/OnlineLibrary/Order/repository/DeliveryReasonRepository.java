// DeliveryReasonRepository.java (필요한 경우)
package OnlineLibrary.Order.repository;

import OnlineLibrary.Order.entity.DeliveryReason;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DeliveryReasonRepository extends JpaRepository<DeliveryReason, String> {
}
