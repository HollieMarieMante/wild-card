package com.example.wildcard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class RouteController {

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
    public String mainPage(){
        return "main";
    }

    @GetMapping("/forgetpass")
    public String forgetpassName() {
        return "forgetpass";
    }
    

    @GetMapping("/cart")
    public String cartPage(){
        return "cart";
    }
}
