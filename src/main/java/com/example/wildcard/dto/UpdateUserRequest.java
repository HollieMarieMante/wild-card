package com.example.wildcard.dto;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@NoArgsConstructor
public class UpdateUserRequest {
    private String userId;
    private String name;
    private String course;
    private String studentId;
    private String email;
    private String mobileNumber;
    private String address;
}
