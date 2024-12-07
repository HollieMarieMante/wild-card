package com.example.wildcard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.wildcard.model.Product;
import com.example.wildcard.model.User;
import com.example.wildcard.service.ProductService;
import com.example.wildcard.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@Controller
public class RouteController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String landingPage() {
        return "home";
    }


    @GetMapping("/login")
    public String login(HttpServletRequest request) {
    if (request.getUserPrincipal() != null) {
        // Check roles and redirect accordingly
        if (request.isUserInRole("SUPER_ADMIN")) {
            return "redirect:/admin";
        } else if (request.isUserInRole("USER")) {
            return "redirect:/main";
        }
    }
    return "login";
    }


    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login";
    }

    @GetMapping("/signup")
    public String signupPage(){
        return "signup";
    }

    @GetMapping("/main")
    public String mainPage(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);

        // Get current user details
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String username = userDetails.getUsername();
            
            User currentUser = userService.findByEmail(username);
            model.addAttribute("user", currentUser);
        }
        
        return "main";
    }
    //for ADMIN
    @GetMapping("/admin")
    public String adminPage(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);

        // Get current user details
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String username = userDetails.getUsername();
            
            User currentUser = userService.findByEmail(username);
            model.addAttribute("user", currentUser);
        }
        
        return "admin";
    }

    @GetMapping("/access-denied")
    public String accessDeniedPage() {   
        return "access-denied";
    }

    @GetMapping("/error")
    public String errorPage() {   
        return "error";
    }



    @GetMapping("/add-product")
    public String addProductPage(Model model){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String username = userDetails.getUsername();
            
            User currentUser = userService.findByEmail(username);
            model.addAttribute("user", currentUser);
        }
        return "addProduct";
    }

    @GetMapping("/forgetpass")
    public String forgetpassName() {
        return "forgetpass";
    }

    @GetMapping("/view-product")
    public String viewProduct(@RequestParam("id") int productId, Model model) {
        try {
            Product product = productService.getProductById(productId);
            if (product != null) {
                model.addAttribute("product", product);
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                if (auth != null && auth.getPrincipal() instanceof UserDetails) {
                    UserDetails userDetails = (UserDetails) auth.getPrincipal();
                    String username = userDetails.getUsername();
                    User currentUser = userService.findByEmail(username);
                    model.addAttribute("user", currentUser);
                }
                return "viewProduct"; // This should be the name of your JSP file
            } else {
                return "error/product-not-found"; // Create this JSP for product not found errors
            }
        } catch (Exception e) {
            // Log the error
            e.printStackTrace();
            return "error/general-error"; // Create this JSP for general errors
        }
    }

    @GetMapping("/view-productadmin")
    public String viewProductadmin(@RequestParam("id") int productId, Model model) {
        try {
            Product product = productService.getProductById(productId);
            if (product != null) {
                model.addAttribute("product", product);
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                if (auth != null && auth.getPrincipal() instanceof UserDetails) {
                    UserDetails userDetails = (UserDetails) auth.getPrincipal();
                    String username = userDetails.getUsername();
                    User currentUser = userService.findByEmail(username);
                    model.addAttribute("user", currentUser);
                }
                return "viewProductadmin"; // This should be the name of your JSP file
            } else {
                return "error/product-not-found"; // Create this JSP for product not found errors
            }
        } catch (Exception e) {
            // Log the error
            e.printStackTrace();
            return "error/general-error"; // Create this JSP for general errors
        }
    }

    
    @GetMapping("/profile")
    public String profilePage(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String username = userDetails.getUsername();
            
            User currentUser = userService.findByEmail(username);
            List<Product> products = productService.getProductsByUser(currentUser.getUserId());
            model.addAttribute("products", products);
            model.addAttribute("user", currentUser);
        }
        return "profile";
    }
    

    @GetMapping("/cart")
    public String cartPage(Model model){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String username = userDetails.getUsername();
            
            User currentUser = userService.findByEmail(username);
            model.addAttribute("user", currentUser);
        }
        return "cart";
    }
    @GetMapping("/usermng")
    public String getUserList(Model model) {
        model.addAttribute("users", userService.findAllUsers());
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) auth.getPrincipal();
            String username = userDetails.getUsername();
            
            User currentUser = userService.findByEmail(username);
            model.addAttribute("user", currentUser);
        }
        return "usermng";
    }
    @PostMapping("/block")
    public String blockUser(@RequestParam int userId) {
        User user = userService.findById(userId);
        if (user != null) {
            user.setRoles("BLOCK");
            userService.save(user);
        }
        return "redirect:usermng";
    }

    @PostMapping("/unblock")
    public String unblockUser(@RequestParam int userId) {
        User user = userService.findById(userId);
        if (user != null) {
            user.setRoles("USER");
            userService.save(user);
        }
        return "redirect:usermng";
    }  
}
