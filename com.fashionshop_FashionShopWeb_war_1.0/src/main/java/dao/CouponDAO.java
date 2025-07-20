package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import java.util.List;
import model.Coupon;
import util.JPAUtil;

public class CouponDAO {

    public Coupon findByCode(String code) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Coupon c WHERE c.code = :code", Coupon.class)
                     .setParameter("code", code)
                     .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
    public List<Coupon> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT c FROM Coupon c ORDER BY c.expiryDate DESC", Coupon.class).getResultList();
    }

    public Coupon findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        return em.find(Coupon.class, id);
    }

    public void insert(Coupon c) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(c);
            tx.commit();
        } finally {
            em.close();
        }
    }

    public void update(Coupon c) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(c);
            tx.commit();
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Coupon c = em.find(Coupon.class, id);
            if (c != null) em.remove(c);
            tx.commit();
        } finally {
            em.close();
        }
    }

}
