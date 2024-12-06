package com.example.wildcard.controller;

import com.example.wildcard.dto.ProductRequest;
import com.example.wildcard.model.Product;
import com.example.wildcard.model.User;
import com.example.wildcard.repository.ProductRepository;
import com.example.wildcard.service.ProductService;
import com.example.wildcard.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProductRepository productRepository;

    // Create a new product
    @PostMapping
    public Product createProduct(@ModelAttribute ProductRequest productRequest) throws IOException {
        Product product = new Product();
        product.setProductName(productRequest.getProductName());
        product.setCategory(productRequest.getCategory());
        product.setDetails(productRequest.getDetails());
        product.setPrice(Float.parseFloat(productRequest.getPrice()));
        product.setQuantity(Integer.parseInt(productRequest.getQuantity()));
        product.setStatus(-1);
        
        MultipartFile image = productRequest.getImage();
        if (image != null && !image.isEmpty()) {
            String imageUrl = saveImage(image);
            product.setImageUrl(imageUrl);
        }
        
        // Find user by email
        User user = userService.findByEmail(productRequest.getEmail());
        if (user == null) {
            throw new IllegalArgumentException("User not found with email: " + productRequest.getEmail());
        }

        product.setUser(user);
        product.setCreatedBy(user.getName());

        return productRepository.save(product);
    }

    @SuppressWarnings("null")
    private String saveImage(MultipartFile image) throws IOException {
        String uploadDir = "src/main/resources/static/product-images/";
        Path uploadPath = Paths.get(uploadDir);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String originalFilename = StringUtils.cleanPath(image.getOriginalFilename());
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = System.currentTimeMillis() + fileExtension;

        Path filePath = uploadPath.resolve(fileName);
        Files.copy(image.getInputStream(), filePath);

        return "/product-images/" + fileName;
    }

    @GetMapping("/{productId}")
    public Product getProductById(@PathVariable int productId) {
        return productService.getProductById(productId);
    }

    // Update an existing product
    @PutMapping("/{productId}")
    public ResponseEntity<Product> updateProduct(
            @PathVariable int productId, 
            @ModelAttribute Product product, 
            @RequestParam String filePath
    ) throws IOException {
        Product updatedProduct = productService.updateProduct(productId, product, filePath);
        return ResponseEntity.ok(updatedProduct);
    }

    // Get all products
    @GetMapping
    public ResponseEntity<List<Product>> getAllProducts() {
        List<Product> products = productService.getAllProducts();
        return ResponseEntity.ok(products);
    }
    //Get product using status
    @GetMapping("/status/{status}")
    public ResponseEntity<List<Product>> getProductsByStatus(@PathVariable int status) {
        List<Product> products = productService.getProductsByStatus(status);
        return ResponseEntity.ok(products);
    }

    //to change status
    @PutMapping("/{productId}/status")
    public ResponseEntity<Map<String, String>> updateProductStatus(
            @PathVariable int productId, 
            @RequestBody Map<String, Integer> request) {
        try {
            // Extract the status value from the request
            Integer status = request.get("status");
            if (status == null) {
                throw new IllegalArgumentException("Status is required");
            }
    
            // Call the service to update the product status
            int result = productService.updateProductStatus(productId, status);
    
            // Prepare the response
            Map<String, String> response = new HashMap<>();
            if (result == 1) {
                response.put("message", "Product status updated successfully.");
                return ResponseEntity.ok(response);
            } else {
                response.put("message", "Failed to update product status.");
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
            }
        } catch (IllegalArgumentException e) {
            // Handle bad requests
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        } catch (RuntimeException e) {
            // Handle not found or other runtime exceptions
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Product not found: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        }
    }
    


    // Delete a product
    @DeleteMapping("/{productId}")
    public ResponseEntity<Void> deleteProduct(@PathVariable int productId) throws IOException {
        productService.deleteProduct(productId);
        return ResponseEntity.noContent().build();
    }

    // Get products by category
    @GetMapping("/category/{category}")
    public ResponseEntity<List<Product>> getProductsByCategory(@PathVariable String category) {
        List<Product> products = productService.getProductsByCategory(category);
        return ResponseEntity.ok(products);
    }

    // Get products by user
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Product>> getProductsByUser(@PathVariable int userId) {
        List<Product> products = productService.getProductsByUser(userId);
        return ResponseEntity.ok(products);
    }

    // Search products by price range
    @GetMapping("/price-range")
    public ResponseEntity<List<Product>> getProductsByPriceRange(
            @RequestParam float minPrice, 
            @RequestParam float maxPrice
    ) {
        List<Product> products = productService.getProductsByPriceRange(minPrice, maxPrice);
        return ResponseEntity.ok(products);
    }

    // Search products by name
    @GetMapping("/search")
    public ResponseEntity<List<Product>> searchProductsByName(@RequestParam String keyword) {
        List<Product> products = productService.searchProductsByName(keyword);
        return ResponseEntity.ok(products);
    }

    // Global exception handler for IOException
    @ExceptionHandler(IOException.class)
    public ResponseEntity<String> handleIOException(IOException e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("Error processing image: " + e.getMessage());
    }
}