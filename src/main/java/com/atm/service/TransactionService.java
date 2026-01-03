package com.atm.service;

import com.atm.dao.TransactionDAO;
import com.atm.entity.Transaction;
import com.atm.entity.User;
import java.util.Date;
import java.util.List;

public class TransactionService {
    private TransactionDAO transactionDAO = new TransactionDAO();
    
    public boolean deposit(User user, Double amount) {
        if (amount <= 0) {
            return false;
        }
        
        Transaction transaction = new Transaction(user, new Date(), "Deposit", amount);
        transactionDAO.saveTransaction(transaction);
        
        return true;
    }
    
    public boolean withdraw(User user, Double amount) {
        if (amount <= 0) {
            return false;
        }
        
        // Check balance
        Double balance = getBalance(user.getPin());
        if (balance < amount) {
            return false;
        }
        
        Transaction transaction = new Transaction(user, new Date(), "Withdrawal", amount);
        transactionDAO.saveTransaction(transaction);
        
        return true;
    }
    
    public List<Transaction> getMiniStatement(String pin) {
        return transactionDAO.getTransactionsByUserPin(pin);
    }
    
    public Double getBalance(String pin) {
        return transactionDAO.getBalanceByUserPin(pin);
    }
}