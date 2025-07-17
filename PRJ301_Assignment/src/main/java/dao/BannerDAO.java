package dao;

import jakarta.persistence.EntityManager;
import model.Banner;
import util.JPAUtil;

import java.util.List;

public class BannerDAO {
    public List<Banner> getByPosition(String position) {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery(
                "SELECT b FROM Banner b WHERE b.position = :pos", Banner.class)
                .setParameter("pos", position)
                .getResultList();
    }
}
