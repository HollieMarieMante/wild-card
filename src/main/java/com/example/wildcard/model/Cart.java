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

    @Column(nullable = false)
    private String productName;

    @Column(nullable = false)
    private String quantity;

    @Column(nullable = false)
    private float subTotal;

    @Column(nullable = false)
    private float totalPrice;

    @OneToOne
    @JoinColumn(name = "userId", nullable = false)
    User user;

    @ManyToMany(mappedBy = "carts")
    private List<Product> products;
}
