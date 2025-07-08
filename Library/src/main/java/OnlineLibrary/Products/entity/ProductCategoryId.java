package OnlineLibrary.Products.entity;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

// 중간 테이블을 사용하기 위한 (복합 참조키) 클래스
@Embeddable
public class ProductCategoryId implements Serializable{
    private Integer productId;
    private String categoryId;

    public ProductCategoryId(){}

    public ProductCategoryId(Integer productId, String categoryId) {
        this.productId = productId;
        this.categoryId = categoryId;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        ProductCategoryId that = (ProductCategoryId) o;
        return Objects.equals(productId, that.productId) && Objects.equals(categoryId, that.categoryId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(productId, categoryId);
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }
}
