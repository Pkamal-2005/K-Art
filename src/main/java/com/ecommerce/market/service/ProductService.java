package com.ecommerce.market.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ecommerce.market.entity.Product;
import com.ecommerce.market.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Product getProductById(Integer id) {
        return productRepository.findById(id).orElse(null);
    }
}
