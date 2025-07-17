package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import model.Product;
import model.Review;
import util.JPAUtil;

import java.util.List;

public class ReviewDAO {
    public void insert(Review r) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(r);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    public void save(Review review) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(review);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Review> getByProduct(Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Review> query = em.createQuery(
                    "SELECT r FROM Review r WHERE r.product = :p ORDER BY r.createdAt DESC", Review.class);
            query.setParameter("p", product);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
