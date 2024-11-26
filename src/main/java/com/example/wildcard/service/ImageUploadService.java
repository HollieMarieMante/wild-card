package com.example.wildcard.service;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@Service
public class ImageUploadService {
    @Autowired
    private Cloudinary cloudinary;

    public String uploadImage(String filePath) throws IOException { 
    
        try {
            // Upload to Cloudinary
            @SuppressWarnings("unchecked")
            Map<String, Object> uploadResult = cloudinary.uploader().upload(
                new File(filePath), ObjectUtils.asMap(
                    "asset_folder", "ecommerce_products",
                    "resource_type", "image"
                    )
            );
    
            // Extract the secure URL
            String secureUrl = (String) uploadResult.get("secure_url");
            if (secureUrl == null || secureUrl.isEmpty()) {
                throw new IOException("Failed to upload image: No secure URL returned");
            }
    
            return secureUrl;
    
        } catch (Exception e) {
            throw new IOException("Failed to upload image to Cloudinary", e);
        }
    }

    // Optional: Method to delete image
    public void deleteImage(String imageUrl) throws IOException {
        // Extract public ID from Cloudinary URL
        String publicId = extractPublicIdFromUrl(imageUrl);
        cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
    }

    private String extractPublicIdFromUrl(String url) {
        // Implement logic to extract public ID from Cloudinary URL
        // This is a simplified example
        String[] parts = url.split("/");
        String filename = parts[parts.length - 1];
        return "products/" + filename.split("\\.")[0];
    }
}