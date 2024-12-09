package com.example.wildcard.repository;

import com.example.wildcard.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    // Custom query methods can be added here if needed

    // Example of a custom method
    User findByEmail(String email);
    User findByStudentId(String studentId);
    User findByName(String name);
    User findByUserId(int userId);
}