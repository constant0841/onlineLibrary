package OnlineLibrary.Products.service;

import OnlineLibrary.Products.entity.ProductEntity;
import OnlineLibrary.Products.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    /**
     * 모든 상품 조회
     */
    public List<ProductEntity> getAllProducts() {
        return productRepository.findAll();
    }

    /**
     * 상품 ID로 조회
     */
    public Optional<ProductEntity> getProductById(Integer productId) {
        return productRepository.findById(productId);
    }

    /**
     * 상품 저장
     */
    public ProductEntity saveProduct(ProductEntity product) {
        return productRepository.save(product);
    }

    /**
     * 상품 삭제
     */
    public void deleteProduct(Integer productId) {
        productRepository.deleteById(productId);
    }

    /**
     * 상품 존재 여부 확인
     */
    public boolean existsById(Integer productId) {
        return productRepository.existsById(productId);
    }

    /**
     * 상품명으로 검색
     */
    public List<ProductEntity> findByProductNameContaining(String productName) {
        return productRepository.findByProductNameContaining(productName);
    }

    /**
     * 저자로 검색
     */
    public List<ProductEntity> findByAuthorContaining(String author) {
        return productRepository.findByAuthorContaining(author);
    }

    /**
     * 출판사로 검색
     */
    public List<ProductEntity> findByPublisherContaining(String publisher) {
        return productRepository.findByPublisherContaining(publisher);
    }

    /**
     * 판매 상태로 검색
     */
    public List<ProductEntity> findBySalesStatus(String salesStatus) {
        return productRepository.findBySalesStatus(salesStatus);
    }

    /**
     * 가격 범위로 검색
     */
    public List<ProductEntity> findByProductPriceBetween(Integer minPrice, Integer maxPrice) {
        return productRepository.findByProductPriceBetween(minPrice, maxPrice);
    }

    /**
     * 재고가 있는 상품만 조회
     */
    public List<ProductEntity> findAvailableProducts() {
        return productRepository.findByStockQuantityGreaterThanAndSalesStatus(0, "판매중");
    }

    /**
     * 베스트셀러 조회 (판매 개수 기준)
     */
    public List<ProductEntity> findBestSellers(int limit) {
        return productRepository.findTop10BySalesStatusOrderBySalesCountDesc("판매중");
    }

    public List<ProductEntity> getProductsByCategory(String categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }
}