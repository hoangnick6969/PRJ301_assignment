// OrderDAO.java
package dao;

import jakarta.persistence.*;
import java.util.LinkedHashMap;
import model.Order;
import util.JPAUtil;

import java.util.List;
import java.util.Map;
import model.Customer;

public class OrderDAO {
    public void insert(Order order) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(order);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    
    public List<Order> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT o FROM Order o", Order.class).getResultList();
    }
    public long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(o) FROM Order o", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    public Order findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Order.class, id);
        } finally {
            em.close();
        }
    }
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            Order order = em.find(Order.class, id);
            if (order != null) {
                em.remove(order); // nếu có quan hệ cascade, sẽ xóa cả OrderDetail
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }


    public void update(Order o) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(o);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Order> getByCustomer(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT o FROM Order o WHERE o.customer.id = :cid ORDER BY o.orderDate DESC", Order.class)
                     .setParameter("cid", customer.getId())
                     .getResultList();
        } finally {
            em.close();
        }
    }
   public Map<String, Double> getMonthlyRevenue(int lastMonths) {
    EntityManager em = JPAUtil.getEntityManager();
    Map<String, Double> map = new LinkedHashMap<>();

    try {
        List<Object[]> results = em.createQuery(
            "SELECT YEAR(o.orderDate), MONTH(o.orderDate), SUM(o.total) " +
            "FROM Order o " +
            "WHERE o.status != 'Hủy' " +
            "GROUP BY YEAR(o.orderDate), MONTH(o.orderDate) " +
            "ORDER BY YEAR(o.orderDate) DESC, MONTH(o.orderDate) DESC"
        ).setMaxResults(lastMonths).getResultList();

        for (Object[] row : results) {
            int year = (Integer) row[0];
            int month = (Integer) row[1];
            Double total = (Double) row[2];

            // Format: Tháng MM/yyyy
            String key = String.format("Tháng %02d/%d", month, year);
            map.put(key, total);
        }

        return map;
    } finally {
        em.close();
    }
}
   public List<Order> findByCustomerId(int customerId) {
    EntityManager em = JPAUtil.getEntityManager();
    try {
        return em.createQuery("SELECT o FROM Order o WHERE o.customer.id = :cid", Order.class)
                 .setParameter("cid", customerId)
                 .getResultList();
    } finally {
        em.close();
    }
}




}
