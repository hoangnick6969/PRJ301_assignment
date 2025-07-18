// OrderDAO.java
package dao;

import jakarta.persistence.*;
import model.Order;
import util.JPAUtil;

import java.util.List;
import model.Customer;

public class OrderDAO {
    public void insert(Order order) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(order);
            em.getTransaction().commit();
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


    public void update(Order order) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(order);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
        } finally {
            em.close();
        }
    }
    public List<Order> getByCustomer(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT o FROM Order o WHERE o.customer.id = :cid ORDER BY o.orderDate DESC", Order.class)
                 .setParameter("cid", customer.getId())
                 .getResultList();
    }

}
