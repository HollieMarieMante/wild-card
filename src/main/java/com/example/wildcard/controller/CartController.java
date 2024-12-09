package com.example.wildcard.controller;

import com.example.wildcard.model.Cart;
import com.example.wildcard.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/carts")
public class CartController {

    private final CartService cartService;

    @Autowired
    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    // Create a new cart

    // Get cart by ID
    @GetMapping("/{cartId}")
    public ResponseEntity<Cart> getCartById(@PathVariable int cartId) {
        return cartService.getCartById(cartId)
                .map(cart -> new ResponseEntity<>(cart, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Get cart by user ID
    @GetMapping("/user/{userId}")
    public ResponseEntity<Cart> getCartByUserId(@PathVariable int userId) {
        return cartService.getCartByUserId(userId)
                .map(cart -> new ResponseEntity<>(cart, HttpStatus.OK))
                .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    // Get all carts for a user (if multiple carts are allowed)
    @GetMapping("/user/{userId}/all")
    public ResponseEntity<List<Cart>> getAllCartsByUserId(@PathVariable int userId) {
        List<Cart> carts = cartService.getAllCartsByUserId(userId);
        return new ResponseEntity<>(carts, HttpStatus.OK);
    }

    // Update cart
    @PutMapping("/{cartId}")
    public ResponseEntity<Cart> updateCart(@PathVariable int cartId, @RequestBody Cart cartDetails) {
        Cart updatedCart = cartService.updateCart(cartId, cartDetails);
        return new ResponseEntity<>(updatedCart, HttpStatus.OK);
    }

    // Delete cart
    @DeleteMapping("/{cartId}")
    public ResponseEntity<Void> deleteCart(@PathVariable int cartId) {
        cartService.deleteCart(cartId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    // Add product to cart
    @PostMapping("/user/{userId}/product/{productId}")
    public ResponseEntity<Cart> addProductToCart(
            @PathVariable int userId,
            @PathVariable int productId,
            @RequestParam(defaultValue = "1") int quantity
    ) {
        Cart updatedCart = cartService.addProductToCart(userId, productId, quantity);
        return new ResponseEntity<>(updatedCart, HttpStatus.OK);
    }

    // Remove product from cart
    @DeleteMapping("/user/{userId}/product/{productId}")
    public ResponseEntity<Cart> removeProductFromCart(
            @PathVariable int userId,
            @PathVariable int productId
    ) {
        Cart updatedCart = cartService.removeProductFromCart(userId, productId);
        return new ResponseEntity<>(updatedCart, HttpStatus.OK);
    }

    // Clear entire cart
    @DeleteMapping("/user/{userId}/clear")
    public ResponseEntity<Void> clearCart(@PathVariable int userId) {
        cartService.clearCart(userId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}