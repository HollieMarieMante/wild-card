package com.example.wildcard.dto;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@NoArgsConstructor
public class ChangePasswordRequest {
    private String userId;
    private String oldPassword;
    private String password;
} 
