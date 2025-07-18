package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Product;
import model.ProductImage;
import util.JPAUtil;

import java.util.List;

public class ProductImageDAO {

    public List<ProductImage> getByProduct(Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<ProductImage> q = em.createQuery(
                "SELECT pi FROM ProductImage pi WHERE pi.product = :product", ProductImage.class);
            q.setParameter("product", product);
            return q.getResultList();
        } finally {
            em.close();
        }
    }
    public List<ProductImage> getByProductId(int productId) {
    EntityManager em = JPAUtil.getEntityManager();
    return em.createQuery("SELECT i FROM ProductImage i WHERE i.product.id = :pid", ProductImage.class)
             .setParameter("pid", productId)
             .getResultList();
}

}
