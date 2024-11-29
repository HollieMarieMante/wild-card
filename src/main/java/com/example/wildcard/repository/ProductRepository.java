package com.example.wildcard.repository;

import com.example.wildcard.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    // Find products by category
    List<Product> findByCategory(String category);

    // Find products by user
    List<Product> findByUser_UserId(int userId);

    // Find products by price range
    List<Product> findByPriceBetween(float minPrice, float maxPrice);

    // Find products by name containing
    List<Product> findByProductNameContainingIgnoreCase(String productName);

    Product findByProductId(int productId);

    List<Product> findByStatus(int status); // Custom query method

;


}