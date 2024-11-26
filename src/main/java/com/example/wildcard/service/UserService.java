package com.example.wildcard.service;

import com.example.wildcard.model.User;
import com.example.wildcard.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // Create a new user
    public User createUser(User user) {
        // Add any validation logic if needed
        return userRepository.save(user);
    }

    // Get all users
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    // Get user by ID
    public Optional<User> getUserById(int userId) {
        return userRepository.findById(userId);
    }

    // Update user
    public User updateUser(int userId, User userDetails) {
        User existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        existingUser.setName(userDetails.getName());
        existingUser.setCourse(userDetails.getCourse());
        existingUser.setStudentId(userDetails.getStudentId());
        existingUser.setEmail(userDetails.getEmail());
        existingUser.setMobileNumber(userDetails.getMobileNumber());
        existingUser.setAddress(userDetails.getAddress());
        // Note: Password update should be handled separately with proper encryption

        return userRepository.save(existingUser);
    }

    // Delete user
    public void deleteUser(int userId) {
        User existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        userRepository.delete(existingUser);
    }

    // Find user by email
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User findById (int id) {
        return userRepository.findByUserId(id);
    }
}