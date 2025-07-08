package OnlineLibrary.Products.service;

import OnlineLibrary.Products.entity.Category;
import OnlineLibrary.Products.repository.CategoryRepository;
import OnlineLibrary.Products.repository.ProductCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ProductCategoryRepository productCategoryRepository;

    /**
     * 모든 카테고리 조회
     */
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }

    /**
     * 카테고리 ID로 조회
     */
    public Optional<Category> getCategoryById(String categoryId) {
        return categoryRepository.findById(categoryId);
    }

    /**
     * 카테고리 존재 여부 확인
     */
    public boolean existsById(String categoryId) {
        return categoryRepository.existsById(categoryId);
    }

    /**
     * 카테고리 저장
     */
    public Category saveCategory(Category category) {
        return categoryRepository.save(category);
    }

    /**
     * 카테고리 삭제
     */
    public void deleteCategory(String categoryId) {
        categoryRepository.deleteById(categoryId);
    }

    /**
     * 카테고리가 상품에 사용되고 있는지 확인
     */
    public boolean isUsedByProducts(String categoryId) {
        return productCategoryRepository.existsByCategoryCategoryId(categoryId);
    }

    /**
     * 카테고리명으로 검색
     */
    public List<Category> searchByName(String categoryName) {
        return categoryRepository.findByCategoryNameContaining(categoryName);
    }

    /**
     * 카테고리 개수 조회
     */
    public long getCategoryCount() {
        return categoryRepository.count();
    }
}