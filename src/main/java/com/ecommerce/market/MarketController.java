package com.ecommerce.market;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ecommerce.market.entity.Product;
import com.ecommerce.market.entity.User;
import com.ecommerce.market.service.CartService;
import com.ecommerce.market.service.ProductService;
import com.ecommerce.market.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MarketController {

    private final ProductService productService;
    private final UserService userService;
    private final CartService cartService;

    public MarketController(ProductService productService,
                            UserService userService,
                            CartService cartService) {
        this.productService = productService;
        this.userService = userService;
        this.cartService = cartService;
    }

    // ===== Login =====
    @GetMapping("/")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        User user = userService.login(username, password);
        if (user != null) {
            session.setAttribute("user", user);
            return "redirect:/products";
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "login";
        }
    }

    // ===== Registration =====
    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String confirmPassword,
                           Model model) {
        
        // Server-side validation
        if (username == null || username.trim().length() < 3) {
            model.addAttribute("error", "Username must be at least 3 characters long");
            return "register";
        }
        
        if (password == null || password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters long");
            return "register";
        }
        
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "register";
        }
        
        // Check if username already exists
        if (userService.usernameExists(username)) {
            model.addAttribute("error", "Username already exists. Please choose a different username.");
            return "register";
        }
        
        // Create new user
        try {
            User newUser = userService.createUser(username.trim(), password);
            if (newUser != null) {
                model.addAttribute("success", "Registration successful! You can now login with your credentials.");
                return "register";
            } else {
                model.addAttribute("error", "Registration failed. Please try again.");
                return "register";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "register";
        }
    }

    // ===== Product listing =====
    @GetMapping("/products")
    public String showProducts(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/"; // redirect to login if not logged in
        }
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "products";
    }

    // ===== Add to cart =====
    @PostMapping("/cart/add")
    public String addToCart(@RequestParam Integer productId,
                            @RequestParam int quantity,
                            HttpSession session) {

        Product product = productService.getProductById(productId);

        if (product != null) {
            cartService.addToCart(product, quantity, session); // pass session here
        }

        return "redirect:/products";
    }

    // ===== View cart =====
    @GetMapping("/cart")
    public String viewCart(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/";
        }

        model.addAttribute("cartItems", cartService.getCart(session));
        return "cart"; // cart.jsp
    }

    // ===== Clear cart =====
    @PostMapping("/cart/clear")
    public String clearCart(HttpSession session) {
        cartService.clearCart(session);
        return "redirect:/cart";
    }

    // ===== Logout =====
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // Increase or decrease quantity
    @PostMapping("/cart/update")
    public String updateCart(@RequestParam Integer productId,
                             @RequestParam int quantity,
                             HttpSession session) {

        Product product = productService.getProductById(productId);
        if (product != null && quantity > 0) {
            cartService.updateQuantity(product, quantity, session);
        }
        return "redirect:/cart";
    }

    // Remove item from cart
    @PostMapping("/cart/remove")
    public String removeFromCart(@RequestParam Integer productId,
                                 HttpSession session) {

        Product product = productService.getProductById(productId);
        if (product != null) {
            cartService.removeFromCart(product, session);
        }
        return "redirect:/cart";
    }

    // Payment route
    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/";
        }
        model.addAttribute("cartItems", cartService.getCart(session));
        return "checkout"; // checkout.jsp
    }
}