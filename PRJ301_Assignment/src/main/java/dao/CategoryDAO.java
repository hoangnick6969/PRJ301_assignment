package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import model.Category;
import util.JPAUtil;

import java.util.List;

public class CategoryDAO {
    public List<Category> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Category> q = em.createQuery("SELECT c FROM Category c", Category.class);
            return q.getResultList();
        } finally {
            em.close();
        }
    }
    public Category findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }

    public void insert(Category c) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(c);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
        } finally {
            em.close();
        }
    }

    public void update(Category c) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(c);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category c = em.find(Category.class, id);
            if (c != null) em.remove(c);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
        } finally {
            em.close();
        }
    }


}
