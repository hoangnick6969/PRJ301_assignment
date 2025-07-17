package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
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
}
