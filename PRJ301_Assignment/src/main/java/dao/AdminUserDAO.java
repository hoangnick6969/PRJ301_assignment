package dao;

import jakarta.persistence.EntityManager;
import model.AdminUser;
import util.JPAUtil;

public class AdminUserDAO {

    public AdminUser checkLogin(String username, String password) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM AdminUser a WHERE a.username = :u AND a.password = :p", AdminUser.class)
                     .setParameter("u", username)
                     .setParameter("p", password)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
    public void update(AdminUser admin) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(admin);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

}
