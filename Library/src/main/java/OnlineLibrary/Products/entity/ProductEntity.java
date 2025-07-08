package OnlineLibrary.Products.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "product")
@Getter @Setter
public class ProductEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

    @Column(name = "product_name", length = 20)
    private String productName;

    @Column(name = "isbn", length = 20)
    private String isbn;

    @Column(name = "product_price")
    private Integer productPrice;

    @Column(name = "publisher", length = 50)
    private String publisher;

    @Column(name = "author", length = 50)
    private String author;

    @Column(name = "stock_quantity")
    private Integer stockQuantity;

    @Column(name = "sales_status", length = 20)
    private String salesStatus;

    @Column(name = "image_url", length = 255) // 길이 증가
    private String imageUrl;

    @Column(name = "product_size", length = 20)
    private String productSize;

    @Column(name = "product_rating")
    private Integer productRating;

    @Column(name = "sales_index") // 새로 추가됨
    private Integer salesIndex;

    @Column(name = "product_description", columnDefinition = "TEXT")
    private String productDescription;

    @Column(name = "thumbnail_url", length = 255) // 길이 증가
    private String thumbnailUrl;

    // 새로 추가: PDF 미리보기 URL
    @Column(name = "pdf_preview_url", length = 255)
    private String pdfPreviewUrl;

    @Column(name = "sales_count")
    private Integer salesCount;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Column(name = "created_date")
    private LocalDate createdDate;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Column(name = "updated_date")
    private LocalDate updatedDate;
}