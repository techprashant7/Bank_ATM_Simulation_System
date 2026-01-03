package com.atm.service;

import com.atm.dao.UserDAO;
import com.atm.entity.User;
import java.util.Random;

public class UserService {
    private UserDAO userDAO = new UserDAO();
    
    public User authenticateUser(String cardNumber, String pin) {
        return userDAO.getUserByCardNumberAndPin(cardNumber, pin);
    }
    
    public boolean registerUser(String name, String city, String pin) {
        
        String cardNumber = generateCardNumber();
        
       
        while (userDAO.getUserByCardNumber(cardNumber) != null) {
            cardNumber = generateCardNumber();
        }
        
        User user = new User(name, city, cardNumber, pin);
        userDAO.saveUser(user);
        
        return true;
    }
    
    public boolean updateUserPin(User user, String newPin) {
        user.setPin(newPin);
        userDAO.updateUser(user);
        return true;
    }
    
    private String generateCardNumber() {
        Random random = new Random();
        StringBuilder cardNumber = new StringBuilder();
        
       
        for (int i = 0; i < 16; i++) {
            cardNumber.append(random.nextInt(10));
        }
        
        return cardNumber.toString();
    }
}