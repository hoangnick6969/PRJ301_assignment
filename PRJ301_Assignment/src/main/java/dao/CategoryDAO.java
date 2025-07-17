package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import model.Category;
import util.JPAUtil;

import java.util.List;

public class CategoryDAO {
    public List<Category> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Category> q = em.createQuery("SELECT c FROM Category c", Category.class);
            return q.getResultList();
        } finally {
            em.close();
        }
    }
}
