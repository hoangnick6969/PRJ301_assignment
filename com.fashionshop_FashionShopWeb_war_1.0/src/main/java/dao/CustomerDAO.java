package dao;

import jakarta.persistence.*;
import java.util.List;
import model.Customer;
import util.JPAUtil;

public class CustomerDAO {

 public Customer findByEmail(String email) {
    EntityManager em = JPAUtil.getEntityManager();
    try {
        return em.createQuery("SELECT c FROM Customer c WHERE c.email = :email", Customer.class)
                 .setParameter("email", email)
                 .getSingleResult();
    } catch (NoResultException e) {
        return null;
    } finally {
        em.close(); // ✅ THÊM DÒNG NÀY
    }
}
  public Customer findByEmailAndPassword(String email, String password) {
     EntityManager em = JPAUtil.getEntityManager();
     try {
         return em.createQuery("SELECT c FROM Customer c WHERE c.email = :email AND c.password = :password", Customer.class)
                  .setParameter("email", email)
                  .setParameter("password", password)
                  .getSingleResult();
     } catch (NoResultException e) {
         return null;
     } finally {
         em.close();
     }
 }

    public void update(Customer customer) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            em.merge(customer);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }


    public void insert(Customer c) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(c);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public long count() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(c) FROM Customer c", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }
    public List<Customer> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT c FROM Customer c", Customer.class).getResultList();
        } finally {
            em.close();
        }
    }

    
public void create(Customer customer) {
    EntityManager em = JPAUtil.getEntityManager();
    try {
        em.getTransaction().begin();
        em.persist(customer);
        em.getTransaction().commit();
    } catch (Exception e) {
        em.getTransaction().rollback();
        throw new RuntimeException("Lỗi khi tạo customer: " + e.getMessage(), e);
    } finally {
        em.close();
    }
}

}
