package com.example.wildcard.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@Table(name = "cart")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int cartId;

    @OneToOne
    @JoinColumn(name = "userId", nullable = false, unique = true)
    private User user;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CartItem> items;

    @Column(nullable = false)
    private float totalPrice;

    // Calculate total price dynamically based on items in the cart
    public void calculateTotalPrice() {
        this.totalPrice = items.stream()
                .map(item -> item.getProduct().getPrice() * item.getQuantity())
                .reduce(0.0f, Float::sum);
    }
}
