package com.atm.dao;

import com.atm.entity.Transaction;
import com.atm.entity.User;
import com.atm.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class TransactionDAO {
    
    public void saveTransaction(Transaction transaction) {
        org.hibernate.Transaction hibernateTransaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            hibernateTransaction = session.beginTransaction();
            session.save(transaction);
            hibernateTransaction.commit();
        } catch (Exception e) {
            if (hibernateTransaction != null) {
                hibernateTransaction.rollback();
            }
            e.printStackTrace();
        }
    }
    
    public List<Transaction> getTransactionsByUserPin(String pin) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Transaction> query = session.createNamedQuery("Transaction.findByUserPin", Transaction.class);
            query.setParameter("pin", pin);
            query.setMaxResults(10); 
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public Double getBalanceByUserPin(String pin) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Double> query = session.createNamedQuery("Transaction.calculateBalance", Double.class);
            query.setParameter("pin", pin);
            Double balance = query.uniqueResult();
            return balance != null ? balance : 0.0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        }
    }
    
    public List<Transaction> getAllTransactions() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Transaction ORDER BY transactionDate DESC", Transaction.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
