package com.ecommerce.market.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ecommerce.market.entity.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {
}
