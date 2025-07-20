package model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "CartItem")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class CartItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "customerId")
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "productId")
    private Product product;

    @Column(nullable = false)
    private int quantity;

    public CartItem() {
    }

    public CartItem(int id, Customer customer, Product product, int quantity) {
        this.id = id;
        this.customer = customer;
        this.product = product;
        this.quantity = quantity;
    }
    
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
}
