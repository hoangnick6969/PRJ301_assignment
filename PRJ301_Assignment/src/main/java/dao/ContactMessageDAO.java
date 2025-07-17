package dao;

import jakarta.persistence.EntityManager;
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
}
