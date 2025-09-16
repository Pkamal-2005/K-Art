package com.ecommerce.market.service;

import org.springframework.stereotype.Service;

import com.ecommerce.market.entity.User;
import com.ecommerce.market.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User login(String username, String password) {
        try {
            return userRepository.findByUsernameAndPassword(username, password);
        } catch (Exception e) {
            return null; // if user not found
        }
    }

    public User createUser(String username, String password) {
        // Validate input
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username cannot be empty");
        }
        
        if (password == null || password.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }
        
        // Trim username and validate length
        username = username.trim();
        if (username.length() < 3) {
            throw new IllegalArgumentException("Username must be at least 3 characters long");
        }
        
        if (username.length() > 50) {
            throw new IllegalArgumentException("Username must not exceed 50 characters");
        }
        
        if (password.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long");
        }
        
        if (password.length() > 100) {
            throw new IllegalArgumentException("Password must not exceed 100 characters");
        }
        
        // Check if username already exists
        if (userRepository.existsByUsername(username)) {
            throw new IllegalArgumentException("Username already exists");
        }
        
        try {
            // Create new user object
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setPassword(password); // In production, hash the password!
            
            // Save to database
            return userRepository.save(newUser);
        } catch (Exception e) {
            throw new RuntimeException("Failed to create user: " + e.getMessage(), e);
        }
    }
    
    public boolean usernameExists(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        return userRepository.existsByUsername(username.trim());
    }
    
    public User getUserById(int id) {
        return userRepository.findById(id);
    }
    
    public User getUserByUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        return userRepository.findByUsername(username.trim());
    }
}