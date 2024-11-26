package com.example.wildcard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.wildcard.model.Product;
import com.example.wildcard.service.ProductService;


@Controller
public class RouteController {

    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public String landingPage() {
        return "home";
    }

    @GetMapping("/login")
    public String loginPage(){
        return "login";
    }

    @GetMapping("/signup")
    public String signupPage(){
        return "signup";
    }

    @GetMapping("/main")
    public String mainPage(Model model) {
        List<Product> products = productService.getAllProducts(); // Or use productController method
        model.addAttribute("products", products);
        return "main";
    }

    @GetMapping("/forgetpass")
    public String forgetpassName() {
        return "forgetpass";
    }
    
    @GetMapping("/profile")
    public String profilePage() {
        return "profile";
    }
    

    @GetMapping("/cart")
    public String cartPage(){
        return "cart";
    }
}
