// OrderDAO.java
package dao;

import jakarta.persistence.*;
import model.Order;
import util.JPAUtil;

import java.util.List;

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
}
