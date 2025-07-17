package dao;

import jakarta.persistence.*;
import model.Banner;
import util.JPAUtil;

import java.util.List;

public class BannerDAO {

    public List<Banner> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT b FROM Banner b", Banner.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Banner> getByPosition(String position) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT b FROM Banner b WHERE b.position = :pos", Banner.class)
                     .setParameter("pos", position)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public Banner findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Banner.class, id);
        } finally {
            em.close();
        }
    }

    public void insert(Banner banner) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(banner);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Banner banner) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(banner);
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
            Banner b = em.find(Banner.class, id);
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
