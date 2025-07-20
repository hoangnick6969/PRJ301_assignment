package dao;

import jakarta.persistence.EntityManager;
import model.Order;
import model.OrderDetail;
import util.JPAUtil;

import java.util.List;

public class OrderDetailDAO {

    public List<OrderDetail> getByOrder(Order order) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM OrderDetail d WHERE d.order.id = :oid", OrderDetail.class)
                    .setParameter("oid", order.getId())
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void insert(OrderDetail detail) {
        EntityManager em = JPAUtil.getEntityManager();
        var trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(detail);
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
        var trans = em.getTransaction();
        try {
            trans.begin();
            OrderDetail d = em.find(OrderDetail.class, id);
            if (d != null) em.remove(d);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
        } finally {
            em.close();
        }
    }
}
