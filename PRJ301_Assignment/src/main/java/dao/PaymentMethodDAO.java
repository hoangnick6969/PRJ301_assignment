package dao;

import jakarta.persistence.EntityManager;
import model.PaymentMethod;
import util.JPAUtil;
import java.util.List;

public class PaymentMethodDAO {
    public List<PaymentMethod> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT p FROM PaymentMethod p", PaymentMethod.class).getResultList();
    }
}
