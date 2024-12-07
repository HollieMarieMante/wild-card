package com.example.wildcard.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.wildcard.dto.ChangePasswordRequest;
import com.example.wildcard.dto.UpdateUserRequest;
import com.example.wildcard.model.User;
import com.example.wildcard.service.UserService;

import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    // Create a new user
    @PostMapping
    public ResponseEntity<User> createUser(@RequestBody User user) {
        User createdUser = userService.createUser(user);
        return new ResponseEntity<>(createdUser, HttpStatus.CREATED);
    }

    // Get all users
    @GetMapping
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = userService.getAllUsers();
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    // Get user by ID
    @GetMapping("/{userId}")
    public ResponseEntity<User> getUserById(@PathVariable int userId) {
        return userService.getUserById(userId)
                .map(user -> new ResponseEntity<>(user, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Update user
    @PutMapping("/update")
    public ResponseEntity<User> updateUser(@ModelAttribute UpdateUserRequest updateUserRequest, HttpServletResponse response) throws IOException {
        User userDetails = new User();
        userDetails.setName(updateUserRequest.getName());
        userDetails.setAddress(updateUserRequest.getAddress());
        userDetails.setCourse(updateUserRequest.getCourse());
        userDetails.setEmail(updateUserRequest.getEmail());
        userDetails.setMobileNumber(updateUserRequest.getMobileNumber());
        userDetails.setStudentId(updateUserRequest.getStudentId());
        User updatedUser = userService.updateUser(Integer.parseInt(updateUserRequest.getUserId()),userDetails);
        return new ResponseEntity<>(updatedUser, HttpStatus.OK);
    }

    // Delete user
    @DeleteMapping("/{userId}")
    public ResponseEntity<Void> deleteUser(@PathVariable int userId) {
        userService.deleteUser(userId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/email/{email}")
    public ResponseEntity<User> getUserByEmail(@PathVariable String email) {
        User user = userService.findByEmail(email);
        if (user != null) {
            return new ResponseEntity<>(user, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/changepass")
    public ResponseEntity<String> changePassword(@ModelAttribute ChangePasswordRequest changePasswordRequest){
        int userId = Integer.parseInt(changePasswordRequest.getUserId());
        String message = userService.updateUserPassword(userId, changePasswordRequest.getOldPassword(), changePasswordRequest.getPassword());
        //if(!message.equals("Success")) {
          //  return new ResponseEntity<>("Password incorrect", HttpStatus.NOT_ACCEPTABLE);
        //}
        return new ResponseEntity<>(message, HttpStatus.OK);
    }

    @PostMapping("/forgetpass")
    public String resetPassword(@RequestParam String email, @RequestParam String studentID,
    @RequestParam String newpassword) {
    User user = userService.findByEmail(email);
    
    if (user == null) {
        return "User not found";
    }
    
    if (!user.getStudentId().equals(studentID)) {
        return "Invalid student ID";
    }
    
    user.setPassword(newpassword); // Consider adding password hashing
    userService.updateUser(user.getUserId(), user);
    
    return "login";
}



}