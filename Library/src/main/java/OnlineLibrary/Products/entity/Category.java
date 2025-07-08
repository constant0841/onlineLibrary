package OnlineLibrary.Products.entity;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "category")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class Category {

    @Id
    @Column(name = "category_id", length = 50)
    private String categoryId;

    @Column(name = "category_name", length = 50)
    private String categoryName;

    @OneToMany(mappedBy = "category")
    private java.util.List<ProductCategory> productCategories;
}
