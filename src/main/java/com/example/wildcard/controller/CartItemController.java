package com.example.wildcard.controller;

import com.example.wildcard.model.CartItem;
import com.example.wildcard.service.CartItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cart/items")
public class CartItemController {

    @Autowired
    private CartItemService cartItemService;

    // Get all items in a specific cart
    @GetMapping("/{cartId}")
    public ResponseEntity<List<CartItem>> getCartItems(@PathVariable int cartId) {
        List<CartItem> items = cartItemService.getItemsByCartId(cartId);
        if (items.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(items);
    }

    // Update the quantity of a cart item
    @PutMapping("/{cartItemId}")
    public ResponseEntity<CartItem> updateCartItemQuantity(
            @PathVariable int cartItemId,
            @RequestParam int quantity) {

        CartItem cartItem = cartItemService.saveCartItem(
                CartItem.builder()
                        .cartItemId(cartItemId)
                        .quantity(quantity)
                        .build()
        );
        return ResponseEntity.ok(cartItem);
    }

    // Remove a specific item from the cart
    @DeleteMapping("/{cartItemId}")
    public ResponseEntity<String> deleteCartItem(@PathVariable int cartItemId) {
        cartItemService.deleteCartItem(cartItemId);
        return ResponseEntity.ok("Cart item removed successfully.");
    }
}
