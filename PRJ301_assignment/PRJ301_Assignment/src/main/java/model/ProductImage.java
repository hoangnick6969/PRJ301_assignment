package model;

import jakarta.persistence.*;
import lombok.*;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "ProductImage")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class ProductImage {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne @JoinColumn(name = "productId")
    private Product product;

    @Column(nullable = false)
    private String imageUrl;

    public ProductImage() {
    }

    public ProductImage(int id, Product product, String imageUrl) {
        this.id = id;
        this.product = product;
        this.imageUrl = imageUrl;
    }
    
}
