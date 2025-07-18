package dao;

import jakarta.persistence.EntityManager;
import model.NewsletterSubscriber;
import util.JPAUtil;


public class NewsletterDAO {

    public void insert(String email) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            NewsletterSubscriber sub = new NewsletterSubscriber();
            sub.setEmail(email);
            sub.setSubscribedAt(new java.util.Date());
            em.persist(sub);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
