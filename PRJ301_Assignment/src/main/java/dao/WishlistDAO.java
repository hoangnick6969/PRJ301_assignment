package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Customer;
import model.Product;
import model.Wishlist;
import util.JPAUtil;

import java.util.List;

public class WishlistDAO {

    public void insert(Wishlist w) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(w);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(Wishlist w) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Wishlist entity = em.find(Wishlist.class, w.getId());
            if (entity != null) em.remove(entity);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Wishlist> getByCustomer(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        TypedQuery<Wishlist> query = em.createQuery(
                "SELECT w FROM Wishlist w WHERE w.customer = :c", Wishlist.class);
        query.setParameter("c", customer);
        return query.getResultList();
    }

    public boolean exists(Customer customer, Product product) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery(
                    "SELECT COUNT(w) FROM Wishlist w WHERE w.customer = :c AND w.product = :p", Long.class)
                    .setParameter("c", customer)
                    .setParameter("p", product)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }
}
