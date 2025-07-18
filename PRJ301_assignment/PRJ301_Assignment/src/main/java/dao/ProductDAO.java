package dao;

import jakarta.persistence.*;
import model.Product;
import util.JPAUtil;

import java.util.List;
import model.BlogPost;
import model.ProductImage;
import model.Review;

public class ProductDAO {
    public List<Product> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Product> getByCategory(int categoryId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT p FROM Product p WHERE p.category.id = :cid", Product.class)
                    .setParameter("cid", categoryId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
    public long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(p) FROM Product p", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    
    public List<Product> searchByKeyword(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Product p WHERE p.name LIKE :kw", Product.class)
                     .setParameter("kw", "%" + keyword + "%")
                     .getResultList();
        } finally {
            em.close();
        }
    }
    public List<Product> getTopSelling(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT od.product FROM OrderDetail od GROUP BY od.product ORDER BY SUM(od.quantity) DESC",
                Product.class)
                .setMaxResults(limit)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public Product findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    public void insert(Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    public void update(Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product p = em.find(Product.class, id);
            if (p != null) {
                em.remove(p);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    public List<Product> getNewest(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT p FROM Product p ORDER BY p.id DESC", Product.class)
                 .setMaxResults(limit)
                 .getResultList();
    }
    public List<BlogPost> getLatest(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT b FROM BlogPost b ORDER BY b.createdAt DESC", BlogPost.class)
                 .setMaxResults(limit)
                 .getResultList();
    }
    


}
