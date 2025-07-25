package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;
import model.ContactMessage;
import util.JPAUtil;

public class ContactMessageDAO {

    public void insert(ContactMessage msg) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(msg);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    public List<ContactMessage> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT m FROM ContactMessage m ORDER BY m.sentAt DESC", ContactMessage.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void save(ContactMessage message) {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            em.persist(message);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
