package com.example.wildcard.controller;

import com.example.wildcard.model.Cart;
import com.example.wildcard.model.Product;
import com.example.wildcard.model.User;
import com.example.wildcard.service.CartService;
import com.example.wildcard.service.ProductService;
import com.example.wildcard.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    // Get cart for a user
    @GetMapping("/get-cart")
    public ResponseEntity<Cart> getCart() {
        Cart cart;
        User user;
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String username = userDetails.getUsername();
            
            user = userService.findByEmail(username);
        
            if (user == null) {
                return ResponseEntity.notFound().build();
            }

            cart = cartService.getOrCreateCart(user);
            return ResponseEntity.ok(cart);
        }
        return ResponseEntity.notFound().build();
    }

    // Add a product to the cart
    @PostMapping("/{userId}/add")
    public ResponseEntity<Cart> addProductToCart(
            @PathVariable int userId,
            @RequestParam int productId,
            @RequestParam int quantity) {

        User user = userService.getUserById(userId)
        .orElseThrow(() -> new RuntimeException("User not found"));;
        if (user == null) {
            return ResponseEntity.notFound().build();
        }

        Product product = productService.getProductById(productId);
        if (product == null || product.getQuantity() < quantity) {
            return ResponseEntity.badRequest().body(null);
        }

        Cart updatedCart = cartService.addProductToCart(user, product, quantity);
        return ResponseEntity.ok(updatedCart);
    }

    // Remove a product from the cart
    @DeleteMapping("/{userId}/remove")
    public ResponseEntity<Cart> removeProductFromCart(
            @PathVariable int userId,
            @RequestParam int productId) {

        User user = userService.getUserById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found"));;
        if (user == null) {
            return ResponseEntity.notFound().build();
        }

        Product product = productService.getProductById(productId);
        if (product == null) {
            return ResponseEntity.badRequest().body(null);
        }

        Cart updatedCart = cartService.removeProductFromCart(user, product);
        return ResponseEntity.ok(updatedCart);
    }

    // Clear all items in the cart
    @DeleteMapping("/{userId}/clear")
    public ResponseEntity<String> clearCart(@PathVariable int userId) {
        User user = userService.getUserById(userId)
                        .orElseThrow(() -> new RuntimeException("User not found"));;
        if (user == null) {
            return ResponseEntity.notFound().build();
        }

        cartService.clearCart(user);
        return ResponseEntity.ok("Cart cleared successfully.");
    }
}
