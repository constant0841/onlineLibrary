package OnlineLibrary.Pay;

import jakarta.persistence.*;

@Entity
@Table(name = "pay_status")
public class PayStatusCode {
    @Id
    @Column(name = "pay_status_code", length = 20)
    private String payStatusCode;

    @Column(name = "pay_status_name", length = 20)
    private String payStatusName;
}
