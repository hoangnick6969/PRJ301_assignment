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
    
}
