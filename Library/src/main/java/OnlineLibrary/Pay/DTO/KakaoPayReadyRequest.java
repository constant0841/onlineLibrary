package OnlineLibrary.Pay.DTO;

import com.fasterxml.jackson.annotation.JsonProperty;

// 결제 준비 요청 DTO
public class KakaoPayReadyRequest {
    private String cid;
    @JsonProperty("partner_order_id")
    private String partnerOrderId;
    @JsonProperty("partner_user_id")
    private String partnerUserId;
    @JsonProperty("item_name")
    private String itemName;
    private Integer quantity;
    @JsonProperty("total_amount")
    private Integer totalAmount;
    @JsonProperty("tax_free_amount")
    private Integer taxFreeAmount;
    @JsonProperty("approval_url")
    private String approvalUrl;
    @JsonProperty("cancel_url")
    private String cancelUrl;
    @JsonProperty("fail_url")
    private String failUrl;

    // Getters and Setters
    public String getCid() { return cid; }
    public void setCid(String cid) { this.cid = cid; }

    public String getPartnerOrderId() { return partnerOrderId; }
    public void setPartnerOrderId(String partnerOrderId) { this.partnerOrderId = partnerOrderId; }

    public String getPartnerUserId() { return partnerUserId; }
    public void setPartnerUserId(String partnerUserId) { this.partnerUserId = partnerUserId; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public Integer getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Integer totalAmount) { this.totalAmount = totalAmount; }

    public Integer getTaxFreeAmount() { return taxFreeAmount; }
    public void setTaxFreeAmount(Integer taxFreeAmount) { this.taxFreeAmount = taxFreeAmount; }

    public String getApprovalUrl() { return approvalUrl; }
    public void setApprovalUrl(String approvalUrl) { this.approvalUrl = approvalUrl; }

    public String getCancelUrl() { return cancelUrl; }
    public void setCancelUrl(String cancelUrl) { this.cancelUrl = cancelUrl; }

    public String getFailUrl() { return failUrl; }
    public void setFailUrl(String failUrl) { this.failUrl = failUrl; }
}

// 결제 준비 응답 DTO
class KakaoPayReadyResponse {
    private String tid;
    @JsonProperty("next_redirect_pc_url")
    private String nextRedirectPcUrl;
    @JsonProperty("next_redirect_mobile_url")
    private String nextRedirectMobileUrl;
    @JsonProperty("android_app_scheme")
    private String androidAppScheme;
    @JsonProperty("ios_app_scheme")
    private String iosAppScheme;
    @JsonProperty("created_at")
    private String createdAt;

    // Getters and Setters
    public String getTid() { return tid; }
    public void setTid(String tid) { this.tid = tid; }

    public String getNextRedirectPcUrl() { return nextRedirectPcUrl; }
    public void setNextRedirectPcUrl(String nextRedirectPcUrl) { this.nextRedirectPcUrl = nextRedirectPcUrl; }

    public String getNextRedirectMobileUrl() { return nextRedirectMobileUrl; }
    public void setNextRedirectMobileUrl(String nextRedirectMobileUrl) { this.nextRedirectMobileUrl = nextRedirectMobileUrl; }

    public String getAndroidAppScheme() { return androidAppScheme; }
    public void setAndroidAppScheme(String androidAppScheme) { this.androidAppScheme = androidAppScheme; }

    public String getIosAppScheme() { return iosAppScheme; }
    public void setIosAppScheme(String iosAppScheme) { this.iosAppScheme = iosAppScheme; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}

// 결제 승인 요청 DTO
class KakaoPayApproveRequest {
    private String cid;
    private String tid;
    @JsonProperty("partner_order_id")
    private String partnerOrderId;
    @JsonProperty("partner_user_id")
    private String partnerUserId;
    @JsonProperty("pg_token")
    private String pgToken;

    // Getters and Setters
    public String getCid() { return cid; }
    public void setCid(String cid) { this.cid = cid; }

    public String getTid() { return tid; }
    public void setTid(String tid) { this.tid = tid; }

    public String getPartnerOrderId() { return partnerOrderId; }
    public void setPartnerOrderId(String partnerOrderId) { this.partnerOrderId = partnerOrderId; }

    public String getPartnerUserId() { return partnerUserId; }
    public void setPartnerUserId(String partnerUserId) { this.partnerUserId = partnerUserId; }

    public String getPgToken() { return pgToken; }
    public void setPgToken(String pgToken) { this.pgToken = pgToken; }
}

// 결제 승인 응답 DTO
class KakaoPayApproveResponse {
    private String aid;
    private String tid;
    private String cid;
    private String sid;
    @JsonProperty("partner_order_id")
    private String partnerOrderId;
    @JsonProperty("partner_user_id")
    private String partnerUserId;
    @JsonProperty("payment_method_type")
    private String paymentMethodType;
    private KakaoPayAmount amount;
    @JsonProperty("card_info")
    private KakaoPayCardInfo cardInfo;
    @JsonProperty("item_name")
    private String itemName;
    @JsonProperty("item_code")
    private String itemCode;
    private Integer quantity;
    @JsonProperty("created_at")
    private String createdAt;
    @JsonProperty("approved_at")
    private String approvedAt;
    private String payload;

    // Getters and Setters
    public String getAid() { return aid; }
    public void setAid(String aid) { this.aid = aid; }

    public String getTid() { return tid; }
    public void setTid(String tid) { this.tid = tid; }

    public String getCid() { return cid; }
    public void setCid(String cid) { this.cid = cid; }

    public String getPartnerOrderId() { return partnerOrderId; }
    public void setPartnerOrderId(String partnerOrderId) { this.partnerOrderId = partnerOrderId; }

    public String getPartnerUserId() { return partnerUserId; }
    public void setPartnerUserId(String partnerUserId) { this.partnerUserId = partnerUserId; }

    public String getPaymentMethodType() { return paymentMethodType; }
    public void setPaymentMethodType(String paymentMethodType) { this.paymentMethodType = paymentMethodType; }

    public KakaoPayAmount getAmount() { return amount; }
    public void setAmount(KakaoPayAmount amount) { this.amount = amount; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public String getApprovedAt() { return approvedAt; }
    public void setApprovedAt(String approvedAt) { this.approvedAt = approvedAt; }
}

// 결제 금액 정보
class KakaoPayAmount {
    private Integer total;
    @JsonProperty("tax_free")
    private Integer taxFree;
    private Integer vat;
    private Integer point;
    private Integer discount;
    @JsonProperty("green_deposit")
    private Integer greenDeposit;

    // Getters and Setters
    public Integer getTotal() { return total; }
    public void setTotal(Integer total) { this.total = total; }

    public Integer getTaxFree() { return taxFree; }
    public void setTaxFree(Integer taxFree) { this.taxFree = taxFree; }

    public Integer getVat() { return vat; }
    public void setVat(Integer vat) { this.vat = vat; }

    public Integer getPoint() { return point; }
    public void setPoint(Integer point) { this.point = point; }

    public Integer getDiscount() { return discount; }
    public void setDiscount(Integer discount) { this.discount = discount; }
}

// 카드 정보
class KakaoPayCardInfo {
    @JsonProperty("kakaopay_purchase_corp")
    private String kakaoPayPurchaseCorp;
    @JsonProperty("kakaopay_purchase_corp_code")
    private String kakaoPayPurchaseCorpCode;
    @JsonProperty("kakaopay_issuer_corp")
    private String kakaoPayIssuerCorp;
    @JsonProperty("kakaopay_issuer_corp_code")
    private String kakaoPayIssuerCorpCode;
    @JsonProperty("bin")
    private String bin;
    @JsonProperty("card_type")
    private String cardType;
    @JsonProperty("install_month")
    private String installMonth;
    @JsonProperty("approved_id")
    private String approvedId;
    @JsonProperty("card_mid")
    private String cardMid;
    @JsonProperty("interest_free_install")
    private String interestFreeInstall;
    @JsonProperty("card_item_code")
    private String cardItemCode;

    // Getters and Setters (생략 - 필요시 추가)
}