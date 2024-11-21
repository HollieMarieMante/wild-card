package com.example.wildcard.service;

import com.example.wildcard.model.Product;
import com.example.wildcard.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    @Autowired
    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    // Create a new product
    public Product createProduct(Product product) {
        return productRepository.save(product);
    }

    // Create a product with image upload
    public Product createProductWithImage(Product product, MultipartFile imageFile) throws IOException {
        if (imageFile != null && !imageFile.isEmpty()) {
            product.setImage(imageFile.getBytes());
        }
        return productRepository.save(product);
    }

    // Get all products
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // Get product by ID
    public Optional<Product> getProductById(int productId) {
        return productRepository.findById(productId);
    }

    // Update product
    public Product updateProduct(int productId, Product productDetails) {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + productId));

        existingProduct.setProductName(productDetails.getProductName());
        existingProduct.setCategory(productDetails.getCategory());
        existingProduct.setPrice(productDetails.getPrice());
        existingProduct.setUser(productDetails.getUser());

        return productRepository.save(existingProduct);
    }

    // Update product with image
    public Product updateProductWithImage(int productId, Product productDetails, MultipartFile imageFile) throws IOException {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + productId));

        existingProduct.setProductName(productDetails.getProductName());
        existingProduct.setCategory(productDetails.getCategory());
        existingProduct.setPrice(productDetails.getPrice());
        existingProduct.setUser(productDetails.getUser());

        if (imageFile != null && !imageFile.isEmpty()) {
            existingProduct.setImage(imageFile.getBytes());
        }

        return productRepository.save(existingProduct);
    }

    // Delete product
    public void deleteProduct(int productId) {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + productId));

        productRepository.delete(existingProduct);
    }

    // Find products by category
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }

    // Find products by user
    public List<Product> getProductsByUser(int userId) {
        return productRepository.findByUser_UserId(userId);
    }

    // Find products by price range
    public List<Product> getProductsByPriceRange(float minPrice, float maxPrice) {
        return productRepository.findByPriceBetween(minPrice, maxPrice);
    }

    // Find products by name
    public List<Product> getProductsByName(String productName) {
        return productRepository.findByProductNameContainingIgnoreCase(productName);
    }
}