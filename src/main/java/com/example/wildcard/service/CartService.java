package com.example.wildcard.service;

import com.example.wildcard.model.Cart;
import com.example.wildcard.model.Product;
import com.example.wildcard.model.User;
import com.example.wildcard.repository.CartRepository;
import com.example.wildcard.repository.ProductRepository;
import com.example.wildcard.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class CartService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    @Autowired
    public CartService(
            CartRepository cartRepository,
            UserRepository userRepository,
            ProductRepository productRepository
    ) {
        this.cartRepository = cartRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
    }

    // Create a new cart
    @Transactional
    public Cart createCart(Cart cart) {
        return cartRepository.save(cart);
    }

    // Get cart by ID
    public Optional<Cart> getCartById(int cartId) {
        return cartRepository.findById(cartId);
    }

    // Get cart by user ID
    public Optional<Cart> getCartByUserId(int userId) {
        return cartRepository.findByUser_UserId(userId);
    }

    // Get all carts for a user
    public List<Cart> getAllCartsByUserId(int userId) {
        return cartRepository.findAllByUser_UserId(userId);
    }

    // Update cart
    @Transactional
    public Cart updateCart(int cartId, Cart cartDetails) {
        Cart existingCart = cartRepository.findById(cartId)
                .orElseThrow(() -> new RuntimeException("Cart not found with id: " + cartId));

        existingCart.setProductName(cartDetails.getProductName());
        existingCart.setQuantity(cartDetails.getQuantity());
        existingCart.setSubTotal(cartDetails.getSubTotal());
        existingCart.setTotalPrice(cartDetails.getTotalPrice());
        existingCart.setUser(cartDetails.getUser());
        existingCart.setProducts(cartDetails.getProducts());

        return cartRepository.save(existingCart);
    }

    // Delete cart
    @Transactional
    public void deleteCart(int cartId) {
        Cart existingCart = cartRepository.findById(cartId)
                .orElseThrow(() -> new RuntimeException("Cart not found with id: " + cartId));

        cartRepository.delete(existingCart);
    }

    // Add product to cart
    @Transactional
    public Cart addProductToCart(int userId, int productId, int quantity) {
        // Find user
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        // Find product
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + productId));

        // Find or create cart for user
        Cart cart = cartRepository.findByUser_UserId(userId)
                .orElse(new Cart());

        // Set user if new cart
        if (cart.getCartId() == 0) {
            cart.setUser(user);
        }

        // Update cart details
        cart.setProductName(product.getProductName());
        cart.setQuantity(String.valueOf(quantity));
        cart.setSubTotal(product.getPrice() * quantity);
        cart.setTotalPrice(product.getPrice() * quantity);

        // Add product to cart
        cart.getProducts().add(product);

        return cartRepository.save(cart);
    }

    // Remove product from cart
    @Transactional
    public Cart removeProductFromCart(int userId, int productId) {
        Cart cart = cartRepository.findByUser_UserId(userId)
                .orElseThrow(() -> new RuntimeException("Cart not found for user id: " + userId));

        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + productId));

        // Remove product from cart
        cart.getProducts().removeIf(p -> p.getProductId() == productId);

        // Recalculate total
        float total = cart.getProducts().stream()
                .map(Product::getPrice)
                .reduce(0f, Float::sum);

        cart.setTotalPrice(total);
        cart.setSubTotal(total);

        return cartRepository.save(cart);
    }

    // Clear entire cart
    @Transactional
    public void clearCart(int userId) {
        Cart cart = cartRepository.findByUser_UserId(userId)
                .orElseThrow(() -> new RuntimeException("Cart not found for user id: " + userId));

        cart.getProducts().clear();
        cart.setTotalPrice(0);
        cart.setSubTotal(0);
        cart.setQuantity("0");

        cartRepository.save(cart);
    }
}