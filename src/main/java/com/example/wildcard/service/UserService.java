package com.example.wildcard.service;

import com.example.wildcard.model.User;
import com.example.wildcard.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    // Use constructor injection instead of field injection
    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

// Create a new user
public User createUser(User user) {
    // Check if the email already exists
    if (userRepository.findByEmail(user.getEmail()) != null) {
        throw new RuntimeException("User with this email already exists");
    }

    // Encode the password
    user.setPassword(passwordEncoder.encode(user.getPassword()));

    // Check if there are no existing users in the database
    if (userRepository.findAll().isEmpty()) {
        // First user gets ADMIN role
        user.setRoles("ADMIN");
    } else {
        // Default role for subsequent users
        if (user.getRoles() == null || user.getRoles().trim().isEmpty()) {
            user.setRoles("USER");
        }
    }

    // Save the user
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
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userDetails.getUserId()));

        existingUser.setName(userDetails.getName());
        existingUser.setCourse(userDetails.getCourse());
        existingUser.setStudentId(userDetails.getStudentId());
        existingUser.setMobileNumber(userDetails.getMobileNumber());
        existingUser.setAddress(userDetails.getAddress());

        if(existingUser.getEmail() != userDetails.getEmail()){
            invalidateSession();
        }

        existingUser.setEmail(userDetails.getEmail());
        User updatedUser = userRepository.save(existingUser);
        
        return updatedUser;
    }

    public String updateUserPassword(int userId, String oldPassword, String password) {
        User existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        if(!passwordEncoder.matches(oldPassword, existingUser.getPassword())){
            return "Not successful";
        }
        String encodedPassword = passwordEncoder.encode(password);
        existingUser.setPassword(encodedPassword);
        invalidateSession();
        userRepository.save(existingUser);
        return "Success";
    }

    private void invalidateSession() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }
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

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return userRepository.findByEmail(email);
    }
    public void save(User user) {
        userRepository.save(user);
    }
    public List<User> findAllUsers() {
        return userRepository.findAll();
    }
}