package OnlineLibrary.Pay.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "pay_method")
public class PayMethodCode {
    @Id
    @Column(name = "pay_method_code", length = 20)
    private String payMethodCode;

    @Column(name = "pay_method_name", length = 20)
    private String payMethodName;
}
