package com.example.wildcard.model;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table(name = "user")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String course;

    @Column(nullable = false)
    private String studentId;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String mobileNumber;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String roles = "USER";

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // Convert roles string to list of GrantedAuthority
        return Arrays.stream(roles.split(","))
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
                .collect(Collectors.toList());
    }

    @Override
    public String getUsername() {
        // Using studentId as username for login
        return this.email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;  // Account never expires
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;  // Account is never locked
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;  // Credentials never expire
    }

    @Override
    public boolean isEnabled() {
        return true;  // Account is always enabled
    }
}