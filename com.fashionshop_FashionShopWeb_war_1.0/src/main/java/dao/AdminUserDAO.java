package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
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
    
    public AdminUser findByUsernameAndPassword(String username, String password) {
        EntityManager em = JPAUtil.getEntityManager();
    try {
        TypedQuery<AdminUser> query = em.createQuery(
            "SELECT a FROM AdminUser a WHERE a.username = :username AND a.password = :password", AdminUser.class);
        query.setParameter("username", username);
        query.setParameter("password", password);
        return query.getSingleResult();
    } catch (NoResultException e) {
        return null;
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
