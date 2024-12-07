package com.example.wildcard.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@NoArgsConstructor
public class UpdateProductRequest {
    private String productId;
    private String productName;
    private String details;
    private String price;
    private String quantity;
    private MultipartFile image; 
}
