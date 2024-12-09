package com.example.wildcard.repository;

import com.example.wildcard.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {
    
    Cart findByUserUserId(int userId);
}
