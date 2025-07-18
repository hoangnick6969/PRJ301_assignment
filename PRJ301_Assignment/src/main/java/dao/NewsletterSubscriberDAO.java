package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import model.NewsletterSubscriber;
import util.JPAUtil;

public class NewsletterSubscriberDAO {
    public void insert(NewsletterSubscriber n) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(n);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public boolean isSubscribed(String email) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.createQuery("SELECT n FROM NewsletterSubscriber n WHERE n.email = :e", NewsletterSubscriber.class)
              .setParameter("e", email)
              .getSingleResult();
            return true;
        } catch (NoResultException e) {
            return false;
        } finally {
            em.close();
        }
    }
}
