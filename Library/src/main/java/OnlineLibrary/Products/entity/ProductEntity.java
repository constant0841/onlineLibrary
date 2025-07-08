package OnlineLibrary.Products.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "product")
public class ProductEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id") // 상품 ID
    private Integer productId;

    @Column(name = "product_name", length = 20) // 상품 이름
    private String productName;

    @Column(name = "product_price") // 상품 가격
    private Integer productPrice;

    @Column(name = "publisher", length = 50) // 출판사
    private String publisher;

    @Column(name = "author", length = 50) // 저자
    private String author;

    @Column(name = "stock_quantity") // 재고 수량
    private Integer stockQuantity;

    @Column(name = "sales_status", length = 20) // 판매 상태 (판매 중, 일시품절 등)
    private String salesStatus;

    @Column(name = "image_url", length = 100) // 상품 이미지 경로
    private String imageUrl;

    @Column(name = "product_size", length = 20) // 상품 크기
    private String productSize;

    @Column(name = "product_rating") // 상품 평점
    private Integer productRating;

    @Column(name = "product_description", columnDefinition = "TEXT") // 상품 설명
    private String productDescription;

    @Column(name = "thumbnail_url", length = 100) // 상품 미리보기 이미지 경로
    private String thumbnailUrl;

    @Column(name = "sales_count") // 판매 개수
    private Integer salesCount;

    @Column(name = "created_date") // 제품 등록일
    private LocalDate createdDate;

    @Column(name = "updated_date") // 제품 판매 종료일
    private LocalDate updatedDate;

    // getter / setter 생략 가능. 필요 시 @Getter, @Setter (Lombok) 추가 가능
}
