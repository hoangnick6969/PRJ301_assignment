// OrderDetailDAO.java
package dao;

import jakarta.persistence.EntityManager;
import model.OrderDetail;
import util.JPAUtil;

public class OrderDetailDAO {
    public void insert(OrderDetail detail) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(detail);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
