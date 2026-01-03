package com.atm.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
@NamedQueries({
    @NamedQuery(name = "User.findByCardNumber", 
                query = "FROM User u WHERE u.cardNumber = :cardNumber"),
    @NamedQuery(name = "User.findByCardNumberAndPin", 
                query = "FROM User u WHERE u.cardNumber = :cardNumber AND u.pin = :pin")
})
public class User extends BaseEntity {
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "city", nullable = false, length = 100)
    private String city;
    
    @Column(name = "card_number", unique = true, nullable = false, length = 16)
    private String cardNumber;
    
    @Column(name = "pin", nullable = false, length = 4)
    private String pin;
    
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Transaction> transactions = new ArrayList<>();
    
    
    public User() {}
    
    public User(String name, String city, String cardNumber, String pin) {
        this.name = name;
        this.city = city;
        this.cardNumber = cardNumber;
        this.pin = pin;
    }
    
    // Getters and Setters
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getCardNumber() {
        return cardNumber;
    }
    
    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    
    public String getPin() {
        return pin;
    }
    
    public void setPin(String pin) {
        this.pin = pin;
    }
    
    public List<Transaction> getTransactions() {
        return transactions;
    }
    
    public void setTransactions(List<Transaction> transactions) {
        this.transactions = transactions;
    }
    
    public void addTransaction(Transaction transaction) {
        transactions.add(transaction);
        transaction.setUser(this);
    }
}