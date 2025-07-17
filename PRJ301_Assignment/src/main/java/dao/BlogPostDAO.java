package dao;

import jakarta.persistence.EntityManager;
import model.BlogPost;
import util.JPAUtil;

import java.util.List;

public class BlogPostDAO {

    public List<BlogPost> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT b FROM BlogPost b ORDER BY b.createdAt DESC", BlogPost.class)
                 .getResultList();
    }

    public BlogPost findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        return em.find(BlogPost.class, id);
    }
}
