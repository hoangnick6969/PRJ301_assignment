package model;

import jakarta.persistence.*;
import java.util.Date;
import lombok.*;

@Entity
@Table(name = "Wishlist",
       uniqueConstraints = @UniqueConstraint(columnNames = {"customerId", "productId"}))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor

public class Wishlist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "customerId")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "productId")
    private Product product;

    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt; // ✅ thêm dòng này

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

}
