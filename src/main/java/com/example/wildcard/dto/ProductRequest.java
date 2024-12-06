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
    public class ProductRequest {
    private String name;
    private String productName;
    private String category;
    private String price;
    private String quantity;
    private MultipartFile image;
    private String details;
    private String email;
    private int status;
    }