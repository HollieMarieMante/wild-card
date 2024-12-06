package com.example.wildcard.service;

import com.example.wildcard.model.Product;
import com.example.wildcard.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    // Update an existing product
    public Product updateProduct(int productId, Product updatedProduct, String filePath) throws IOException {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // Update product details
        existingProduct.setProductName(updatedProduct.getProductName());
        existingProduct.setCategory(updatedProduct.getCategory());
        existingProduct.setPrice(updatedProduct.getPrice());
        existingProduct.setDetails(updatedProduct.getDetails());

        return productRepository.save(existingProduct);
    }

    // Get all products
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // Get product by ID
    public Product getProductById(int productId) {
        return productRepository.findByProductId(productId);
    }

    // Delete a product
    public void deleteProduct(int productId) throws IOException {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        productRepository.deleteById(productId);
    }
    @Transactional
    public int updateProductStatus(int productId, int status) {
        try {
            Product product = productRepository.findById(productId)
                    .orElseThrow(() -> new RuntimeException("Product not found"));
            
            product.setStatus(status);
            productRepository.save(product);
            return 1; // Indicate success
        } catch (Exception e) {
            // Log the exception if needed
            System.err.println("Error updating product status: " + e.getMessage());
            return 0; // Indicate failure
        }
    }
    
 



    // Additional custom methods based on repository
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }

    public List<Product> getProductsByUser(int userId) {
        return productRepository.findByUser_UserId(userId);
    }

    public List<Product> getProductsByPriceRange(float minPrice, float maxPrice) {
        return productRepository.findByPriceBetween(minPrice, maxPrice);
    }

    public List<Product> searchProductsByName(String keyword) {
        return productRepository.findByProductNameContainingIgnoreCase(keyword);
    }

    public List<Product> getProductsByStatus(int status) {
        return productRepository.findByStatus(status);
    }
}