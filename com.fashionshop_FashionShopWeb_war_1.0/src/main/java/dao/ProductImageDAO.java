package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.Collections;
import model.Product;
import model.ProductImage;
import util.JPAUtil;

import java.util.List;

public class ProductImageDAO {

 
    public List<ProductImage> getByProductId(int productId) {
    EntityManager em = JPAUtil.getEntityManager();
    return em.createQuery("SELECT i FROM ProductImage i WHERE i.product.id = :pid", ProductImage.class)
             .setParameter("pid", productId)
             .getResultList();
}
    public List<ProductImage> getByProduct(Product product) {
    EntityManager em = JPAUtil.getEntityManager();
    try {
        return em.createQuery("SELECT i FROM ProductImage i WHERE i.product = :product", ProductImage.class)
                 .setParameter("product", product)
                 .getResultList();
    } catch (Exception e) {
        e.printStackTrace();  
        return Collections.emptyList();
    } finally {
        em.close();
    }
}

}
