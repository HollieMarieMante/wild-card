package com.example.wildcard.service;

import com.example.wildcard.model.CartItem;
import com.example.wildcard.repository.CartItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartItemService {

    @Autowired
    private CartItemRepository cartItemRepository;


    // Find all items in a cart
    public List<CartItem> getItemsByCartId(int cartId) {
        return cartItemRepository.findByCartCartId(cartId);
    }

    // Save or update a cart item
    public CartItem saveCartItem(CartItem cartItem) {
        return cartItemRepository.save(cartItem);
    }

    // Delete a cart item
    public void deleteCartItem(int cartItemId) {
        cartItemRepository.deleteById(cartItemId);
    }
}
