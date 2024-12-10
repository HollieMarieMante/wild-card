package com.example.wildcard.repository;

import com.example.wildcard.model.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Integer> {

    List<CartItem> findByCartCartId(int cartId);
    Optional<CartItem> findById(int cartItemId);
}
