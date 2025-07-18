package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import model.ShippingMethod;
import util.JPAUtil;

import java.util.List;

public class ShippingMethodDAO {

    public List<ShippingMethod> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM ShippingMethod s", ShippingMethod.class).getResultList();
        } finally {
            em.close();
        }
    }

    public ShippingMethod findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(ShippingMethod.class, id);
        } finally {
            em.close();
        }
    }
    

}
