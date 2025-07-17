package dao;

import jakarta.persistence.EntityManager;
import model.ShippingMethod;
import util.JPAUtil;
import java.util.List;

public class ShippingMethodDAO {
    public List<ShippingMethod> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT s FROM ShippingMethod s", ShippingMethod.class).getResultList();
    }
}
