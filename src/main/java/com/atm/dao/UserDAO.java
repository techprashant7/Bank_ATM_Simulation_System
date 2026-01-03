package com.atm.dao;

import com.atm.entity.User;
import com.atm.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class UserDAO {
    
    public void saveUser(User user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    
    public User getUserByCardNumber(String cardNumber) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createNamedQuery("User.findByCardNumber", User.class);
            query.setParameter("cardNumber", cardNumber);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public User getUserByCardNumberAndPin(String cardNumber, String pin) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<User> query = session.createNamedQuery("User.findByCardNumberAndPin", User.class);
            query.setParameter("cardNumber", cardNumber);
            query.setParameter("pin", pin);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public void updateUser(User user) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(user);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    
    public List<User> getAllUsers() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM User", User.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}