package OnlineLibrary.Products.repository;

import OnlineLibrary.Products.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, String> {

    /**
     * 카테고리명으로 검색 (부분 일치)
     */
    List<Category> findByCategoryNameContaining(String categoryName);

    /**
     * 카테고리명으로 정확히 검색
     */
    Category findByCategoryName(String categoryName);

    /**
     * 카테고리 ID 존재 여부 확인
     */
    boolean existsByCategoryId(String categoryId);

    /**
     * 카테고리명 존재 여부 확인
     */
    boolean existsByCategoryName(String categoryName);

    /**
     * 모든 카테고리를 ID 순으로 정렬하여 조회
     */
    List<Category> findAllByOrderByCategoryIdAsc();

    /**
     * 모든 카테고리를 이름 순으로 정렬하여 조회
     */
    List<Category> findAllByOrderByCategoryNameAsc();
}