package dao;

import jakarta.persistence.*;
import java.util.ArrayList;
import model.CartItem;
import model.Customer;
import model.Product;
import util.JPAUtil;

import java.util.List;

public class CartItemDAO {

    public void saveOrUpdate(Customer customer, Product product, int quantity) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            TypedQuery<CartItem> query = em.createQuery(
                "SELECT c FROM CartItem c WHERE c.customer.id = :customerId AND c.product.id = :productId",
                CartItem.class);
            query.setParameter("customerId", customer.getId());
            query.setParameter("productId", product.getId());

            List<CartItem> results = query.getResultList();
            if (!results.isEmpty()) {
                CartItem item = results.get(0);
                item.setQuantity(item.getQuantity() + quantity);
                em.merge(item);
            } else {
                CartItem item = new CartItem();
                item.setCustomer(customer);
                item.setProduct(product);
                item.setQuantity(quantity);
                em.persist(item);
            }

            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    public void insert(CartItem item) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            em.persist(item);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<CartItem> getCartByCustomer(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM CartItem c WHERE c.customer.id = :id", CartItem.class)
                    .setParameter("id", customerId)
                    .getResultList();
        } finally {
            em.close();
        }
    }
    public CartItem findByCustomerAndProduct(Customer customer, Product product) {
    try {
        EntityManager em = JPAUtil.getEntityManager();
        TypedQuery<CartItem> query = em.createQuery(
            "SELECT c FROM CartItem c WHERE c.customer.id = :customerId AND c.product.id = :productId", CartItem.class);
        query.setParameter("customerId", customer.getId());
        query.setParameter("productId", product.getId());

        return query.getResultList().stream().findFirst().orElse(null);
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    }
}
public void update(CartItem item) {
    EntityManager em = JPAUtil.getEntityManager();
    try {
        
        em.getTransaction().begin();
        em.merge(item);
        em.getTransaction().commit();
    } catch (Exception e) {
        em.getTransaction().rollback();
        e.printStackTrace();
    }
}
    public List<CartItem> getByCustomer(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            TypedQuery<CartItem> query = em.createQuery(
                "SELECT c FROM CartItem c WHERE c.customer.id = :customerId", CartItem.class);
            query.setParameter("customerId", customer.getId());
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public void clearCart(int customerId) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createQuery("DELETE FROM CartItem c WHERE c.customer.id = :id")
              .setParameter("id", customerId)
              .executeUpdate();
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
            CartItem item = em.find(CartItem.class, id);
            if (item != null) em.remove(item);
            tx.commit();
        } finally {
            em.close();
        }
    }
}
