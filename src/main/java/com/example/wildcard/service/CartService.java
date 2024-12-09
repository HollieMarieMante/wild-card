package com.example.wildcard.service;

import com.example.wildcard.model.Cart;
import com.example.wildcard.model.CartItem;
import com.example.wildcard.model.Product;
import com.example.wildcard.model.User;
import com.example.wildcard.repository.CartItemRepository;
import com.example.wildcard.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartItemRepository cartItemRepository;

    // Retrieve the cart by user ID, or create a new one if none exists
    public Cart getOrCreateCart(User user) {
        Cart cart = cartRepository.findByUserUserId(user.getUserId());
        if (cart == null) {
            cart = Cart.builder()
                    .user(user)
                    .totalPrice(0.0f)
                    .build();
            cart = cartRepository.save(cart);
        }
        return cart;
    }

    // Add a product to the cart
    public Cart addProductToCart(User user, Product product, int quantity) {
        Cart cart = getOrCreateCart(user);

        CartItem cartItem = cartItemRepository.findByCartCartId(cart.getCartId())
                .stream()
                .filter(item -> item.getProduct().getProductId() == product.getProductId())
                .findFirst()
                .orElse(null);

        if (cartItem == null) {
            cartItem = CartItem.builder()
                    .cart(cart)
                    .product(product)
                    .quantity(quantity)
                    .build();
        } else {
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
        }

        cartItemRepository.save(cartItem);

        cart.calculateTotalPrice();
        cartRepository.save(cart);

        return cart;
    }

    // Remove a product from the cart
    public Cart removeProductFromCart(User user, Product product) {
        Cart cart = getOrCreateCart(user);

        List<CartItem> cartItems = cartItemRepository.findByCartCartId(cart.getCartId());
        cartItems.stream()
                .filter(item -> item.getProduct().getProductId() == product.getProductId())
                .findFirst()
                .ifPresent(cartItemRepository::delete);

        cart.calculateTotalPrice();
        cartRepository.save(cart);

        return cart;
    }

    public void clearCart(User user) {
        Cart cart = getOrCreateCart(user);
        cartItemRepository.deleteAll(cart.getItems());
        cart.setTotalPrice(0.0f);
        cartRepository.save(cart);
    }
}
