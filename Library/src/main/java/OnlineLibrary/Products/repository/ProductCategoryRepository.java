package OnlineLibrary.Products.repository;

import OnlineLibrary.Products.entity.ProductCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface ProductCategoryRepository extends JpaRepository<ProductCategory, Long> {

    // 특정 상품의 모든 카테고리 조회
    List<ProductCategory> findByProductProductId(Long productId);


    // 특정 카테고리의 모든 상품 조회
    List<ProductCategory> findByCategoryCategoryId(String categoryId);

    // 특정 카테고리가 상품에 사용되고 있는지 확인
    boolean existsByCategoryCategoryId(String categoryId);


    // 특정 상품이 특정 카테고리에 속해있는지 확인
    boolean existsByProductProductIdAndCategoryCategoryId(Long productId, String categoryId);


    // 특정 상품의 모든 카테고리 관계 삭제
    @Modifying
    @Transactional
    void deleteByProductProductId(Long productId);


    // 특정 카테고리의 모든 상품 관계 삭제
    @Modifying
    @Transactional
    void deleteByCategoryCategoryId(String categoryId);


    // 특정 상품-카테고리 관계 삭제
    @Modifying
    @Transactional
    void deleteByProductProductIdAndCategoryCategoryId(Long productId, String categoryId);


    // 카테고리별 상품 개수 조회
    @Query("SELECT COUNT(pc) FROM ProductCategory pc WHERE pc.category.categoryId = :categoryId")
    long countByCategoryId(@Param("categoryId") String categoryId);


    // 상품별 카테고리 개수 조회
    @Query("SELECT COUNT(pc) FROM ProductCategory pc WHERE pc.product.productId = :productId")
    long countByProductId(@Param("productId") Long productId);


    // 카테고리별 상품 ID 목록 조회
    @Query("SELECT pc.product.productId FROM ProductCategory pc WHERE pc.category.categoryId = :categoryId")
    List<Long> findProductIdsByCategoryId(@Param("categoryId") String categoryId);


    // 상품별 카테고리 ID 목록 조회
    @Query("SELECT pc.category.categoryId FROM ProductCategory pc WHERE pc.product.productId = :productId")
    List<String> findCategoryIdsByProductId(@Param("productId") Long productId);


    // 여러 카테고리에 속한 상품들 조회
    @Query("SELECT DISTINCT pc.product.productId FROM ProductCategory pc WHERE pc.category.categoryId IN :categoryIds")
    List<Long> findProductIdsByCategoryIds(@Param("categoryIds") List<String> categoryIds);


    // 카테고리별 상품 관계 전체 조회 (카테고리 정보 포함)
    @Query("SELECT pc FROM ProductCategory pc " +
            "JOIN FETCH pc.category c " +
            "WHERE c.categoryId = :categoryId " +
            "ORDER BY pc.product.productName")
    List<ProductCategory> findWithCategoryByCategoryId(@Param("categoryId") String categoryId);


    // 상품별 카테고리 관계 전체 조회 (상품 정보 포함)
    @Query("SELECT pc FROM ProductCategory pc " +
            "JOIN FETCH pc.product p " +
            "WHERE p.productId = :productId " +
            "ORDER BY pc.category.categoryName")
    List<ProductCategory> findWithProductByProductId(@Param("productId") Long productId);


    // 모든 관계를 상품명 기준으로 정렬하여 조회
    @Query("SELECT pc FROM ProductCategory pc " +
            "JOIN FETCH pc.product p " +
            "JOIN FETCH pc.category c " +
            "ORDER BY p.productName, c.categoryName")
    List<ProductCategory> findAllWithProductAndCategory();


    // 특정 카테고리들의 상품 개수 통계
    @Query("SELECT c.categoryId, c.categoryName, COUNT(pc) " +
            "FROM Category c LEFT JOIN ProductCategory pc ON c.categoryId = pc.category.categoryId " +
            "WHERE c.categoryId IN :categoryIds " +
            "GROUP BY c.categoryId, c.categoryName " +
            "ORDER BY COUNT(pc) DESC")
    List<Object[]> getProductCountByCategories(@Param("categoryIds") List<String> categoryIds);


    // 카테고리별 상품 개수 전체 통계
    @Query("SELECT c.categoryId, c.categoryName, COUNT(pc) " +
            "FROM Category c LEFT JOIN ProductCategory pc ON c.categoryId = pc.category.categoryId " +
            "GROUP BY c.categoryId, c.categoryName " +
            "ORDER BY COUNT(pc) DESC")
    List<Object[]> getAllCategoryProductCounts();
}