package dao;

import jakarta.persistence.*;
import model.CartItem;
import model.Customer;
import util.JPAUtil;

import java.util.List;

public class CartItemDAO {

    public List<CartItem> getByCustomer(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM CartItem c WHERE c.customer = :cust", CartItem.class)
                     .setParameter("cust", customer)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public void insert(CartItem item) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(item);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            CartItem item = em.find(CartItem.class, id);
            if (item != null) em.remove(item);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void clearByCustomer(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.createQuery("DELETE FROM CartItem c WHERE c.customer = :cust")
              .setParameter("cust", customer)
              .executeUpdate();
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
