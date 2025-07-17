package dao;

import jakarta.persistence.*;
import model.BlogPost;
import util.JPAUtil;

import java.util.List;

public class BlogPostDAO {

    public List<BlogPost> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT b FROM BlogPost b ORDER BY b.createdAt DESC", BlogPost.class)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public BlogPost findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(BlogPost.class, id);
        } finally {
            em.close();
        }
    }

    public void insert(BlogPost blog) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(blog);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(BlogPost blog) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(blog);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            BlogPost b = em.find(BlogPost.class, id);
            if (b != null) em.remove(b);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
