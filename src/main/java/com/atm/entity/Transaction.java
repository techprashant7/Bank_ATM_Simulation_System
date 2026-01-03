package com.atm.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "transactions")
@NamedQueries({
    @NamedQuery(name = "Transaction.findByUserPin", 
                query = "FROM Transaction t WHERE t.user.pin = :pin ORDER BY t.transactionDate DESC"),
    @NamedQuery(name = "Transaction.calculateBalance", 
                query = "SELECT SUM(CASE WHEN t.transactionType = 'Deposit' THEN t.amount ELSE -t.amount END) " +
                        "FROM Transaction t WHERE t.user.pin = :pin")
})
public class Transaction extends BaseEntity {
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "transaction_date", nullable = false)
    private Date transactionDate;
    
    @Column(name = "transaction_type", nullable = false, length = 20)
    private String transactionType;
    
    @Column(name = "amount", nullable = false)
    private Double amount;
    
    
    public Transaction() {}
    
    public Transaction(User user, Date transactionDate, String transactionType, Double amount) {
        this.user = user;
        this.transactionDate = transactionDate;
        this.transactionType = transactionType;
        this.amount = amount;
    }
    

    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public Date getTransactionDate() {
        return transactionDate;
    }
    
    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }
    
    public String getTransactionType() {
        return transactionType;
    }
    
    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }
    
    public Double getAmount() {
        return amount;
    }
    
    public void setAmount(Double amount) {
        this.amount = amount;
    }
}