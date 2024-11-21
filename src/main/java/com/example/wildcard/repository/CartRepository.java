package com.example.wildcard.repository;

import com.example.wildcard.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {
    // Find cart by user ID
    Optional<Cart> findByUser_UserId(int userId);

    // Find all carts for a specific user
    List<Cart> findAllByUser_UserId(int userId);
}