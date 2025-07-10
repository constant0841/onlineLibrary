package OnlineLibrary.Products.repository;

import OnlineLibrary.Products.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {

    /**
     * 상품명으로 검색 (부분 일치)
     */
    List<ProductEntity> findByProductNameContaining(String productName);

    /**
     * 저자로 검색 (부분 일치)
     */
    List<ProductEntity> findByAuthorContaining(String author);

    /**
     * 출판사로 검색 (부분 일치)
     */
    List<ProductEntity> findByPublisherContaining(String publisher);

    /**
     * 판매 상태로 검색
     */
    List<ProductEntity> findBySalesStatus(String salesStatus);

    /**
     * 가격 범위로 검색
     */
    List<ProductEntity> findByProductPriceBetween(Integer minPrice, Integer maxPrice);

    /**
     * 재고 수량과 판매 상태로 검색
     */
    List<ProductEntity> findByStockQuantityGreaterThanAndSalesStatus(Integer stockQuantity, String salesStatus);

    /**
     * 베스트셀러 조회 (판매 개수 기준 상위 10개)
     */
    List<ProductEntity> findTop10BySalesStatusOrderBySalesCountDesc(String salesStatus);

    /**
     * 등록일 범위로 검색
     */
    List<ProductEntity> findByCreatedDateBetween(LocalDate startDate, LocalDate endDate);

    /**
     * 평점 이상인 상품 조회
     */
    List<ProductEntity> findByProductRatingGreaterThanEqual(Integer rating);

    /**
     * 복합 검색 (상품명, 저자, 출판사 중 하나라도 포함)
     */
    @Query("SELECT p FROM ProductEntity p WHERE " +
            "p.productName LIKE %:keyword% OR " +
            "p.author LIKE %:keyword% OR " +
            "p.publisher LIKE %:keyword%")
    List<ProductEntity> findByKeyword(@Param("keyword") String keyword);

    /**
     * 판매 상태별 개수 조회
     */
    @Query("SELECT p.salesStatus, COUNT(p) FROM ProductEntity p GROUP BY p.salesStatus")
    List<Object[]> countBySalesStatus();

    /**
     * 재고 부족 상품 조회 (재고 수량이 특정 값 이하)
     */
    List<ProductEntity> findByStockQuantityLessThanEqual(Integer stockQuantity);

    /**
     * 가격대별 상품 조회 (정렬 포함)
     */
    List<ProductEntity> findBySalesStatusOrderByProductPriceAsc(String salesStatus);
    List<ProductEntity> findBySalesStatusOrderByProductPriceDesc(String salesStatus);

    /**
     * 최신 등록 상품 조회
     */
    List<ProductEntity> findTop10BySalesStatusOrderByCreatedDateDesc(String salesStatus);

    /**
     * 카테고리별 상품 조회 (JOIN 사용)
     */
    @Query("SELECT DISTINCT pc.product FROM ProductCategory pc " +
            "WHERE pc.category.categoryId = :categoryId")
    List<ProductEntity> findByCategoryId(@Param("categoryId") String categoryId);
}