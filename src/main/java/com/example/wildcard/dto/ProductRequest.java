package com.example.wildcard.dto;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@NoArgsConstructor
    public class ProductRequest {
    private String productName;
    private String category;
    private String price;
    private String quantity;
    private String details;
    private String imageUrl;
    private String email;

    }