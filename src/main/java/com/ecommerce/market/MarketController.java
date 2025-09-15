package com.ecommerce.market;

import com.ecommerce.market.entity.Product;
import com.ecommerce.market.entity.User;
import com.ecommerce.market.service.CartService;
import com.ecommerce.market.service.ProductService;
import com.ecommerce.market.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    model.addAttribute("cartItems", cartService.getCart(session));
    return "checkout"; // checkout.jsp
}


}
