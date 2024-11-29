package com.example.wildcard.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.example.wildcard.model.User;
import com.example.wildcard.repository.UserRepository;

@Configuration
public class SuperAdminInitializer {

    @Bean
    public CommandLineRunner initializeSuperAdmin(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        return args -> {
            // Check if the user table is empty
            if (userRepository.count() == 0) {
                // Create super admin user
                User superAdmin = User.builder()
                        .userId(1) // Explicitly setting userId to 1
                        .name("Super Admin")
                        .course("N/A")
                        .studentId("N/A")
                        .email("superadmin@example.com")
                        .mobileNumber("0000000000")
                        .password(passwordEncoder.encode("admin123"))
                        .address("System Default")
                        .roles("SUPER_ADMIN")
                        .build();

                userRepository.save(superAdmin);
                System.out.println("Super admin account created successfully!");
            }
        };
    }
}
