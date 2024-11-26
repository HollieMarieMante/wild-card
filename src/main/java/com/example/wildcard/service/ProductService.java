package com.example.wildcard.service;

import com.example.wildcard.model.Product;
import com.example.wildcard.model.User;
import com.example.wildcard.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ImageUploadService imageUploadService;

    @Autowired
    private UserService userService;

    // Create a new product
    public Product createProduct(Product product,String filePath, String email) throws IOException {
        // If an image is provided, upload it and set the URL
        User user = userService.findByEmail(email);
        String imageUrl = imageUploadService.uploadImage(filePath);
        product.setImageUrl(imageUrl);

        product.setUser(user);
        return productRepository.save(product);
    }

    // Update an existing product
    public Product updateProduct(int productId, Product updatedProduct, String filePath) throws IOException {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // Update product details
        existingProduct.setProductName(updatedProduct.getProductName());
        existingProduct.setCategory(updatedProduct.getCategory());
        existingProduct.setPrice(updatedProduct.getPrice());
        existingProduct.setDetails(updatedProduct.getDetails());
            
            // Upload new image
            String newImageUrl = imageUploadService.uploadImage(filePath);
            existingProduct.setImageUrl(newImageUrl);

        return productRepository.save(existingProduct);
    }

    // Get all products
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // Get product by ID
    public Optional<Product> getProductById(int productId) {
        return productRepository.findById(productId);
    }

    // Delete a product
    public void deleteProduct(int productId) throws IOException {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // Delete associated image if exists
        if (product.getImageUrl() != null) {
            imageUploadService.deleteImage(product.getImageUrl());
        }

        productRepository.deleteById(productId);
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
}