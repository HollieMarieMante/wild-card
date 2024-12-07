package com.example.wildcard.service;

import com.example.wildcard.model.Product;
import com.example.wildcard.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

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
        deleteImage(product.getImageUrl());
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

    public String updateProduct(int productId, Product newProduct, MultipartFile newImage){
        try{
            Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));

                existingProduct.setProductName(newProduct.getProductName());
                existingProduct.setDetails(newProduct.getDetails());
                existingProduct.setPrice(newProduct.getPrice());
                existingProduct.setQuantity(newProduct.getQuantity());
                if(newImage == null){
                    productRepository.save(existingProduct);
                    return "Product details updated successfully!";
                }
                
                System.out.println("Product image url" + existingProduct.getImageUrl());
                boolean isDeleted = deleteImage(existingProduct.getImageUrl());
                if(isDeleted){
                    String newImageUrl = saveImage(newImage);
                    existingProduct.setImageUrl(newImageUrl);
                    productRepository.save(existingProduct);
                    return "Product details and image updated successfully!";
                }else{
                    return "Old image wasn't deleted";
                }
        }catch(Exception e){
            return e.getMessage();
        }
    }

    private boolean deleteImage(String imageDir) throws IOException{
        System.out.println("I was called!");
        String directory = "src/main/resources/static";
        Path filePath = Paths.get(directory + imageDir);

        if(Files.exists(filePath)) {
            Files.delete(filePath);
            return true;
        }

        return false;
    }

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