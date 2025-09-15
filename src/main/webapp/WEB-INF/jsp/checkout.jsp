<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | K-Art</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #7c3aed;
            --primary-dark: #6d28d9;
            --dark-bg: #121212;
            --dark-surface: #1e1e1e;
            --dark-card: #252525;
            --text-primary: #f5f5f5;
            --text-secondary: #b0b0b0;
            --error: #ef4444;
            --success: #10b981;
            --border-color: rgba(255, 255, 255, 0.1);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, var(--dark-bg) 0%, #1a1a2e 100%);
            color: var(--text-primary);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .logo h1 {
            font-size: 28px;
            font-weight: 700;
            background: linear-gradient(90deg, var(--primary) 0%, #a78bfa 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .nav-links {
            display: flex;
            gap: 25px;
            align-items: center;
        }
        
        .nav-link {
            color: var(--text-primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: color 0.3s ease;
        }
        
        .nav-link:hover {
            color: var(--primary);
        }
        
        .page-title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
            position: relative;
            padding-bottom: 15px;
        }
        
        .page-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary) 0%, var(--primary-dark) 100%);
            border-radius: 3px;
        }
        
        .checkout-container {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 30px;
        }
        
        .cart-items {
            background: var(--dark-card);
            border-radius: 12px;
            padding: 25px;
            border: 1px solid var(--border-color);
        }
        
        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .cart-table th {
            text-align: left;
            padding: 15px 10px;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-secondary);
            font-weight: 600;
        }
        
        .cart-table td {
            padding: 20px 10px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .cart-table tr:last-child td {
            border-bottom: none;
        }
        
        .product-cell {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .product-image {
            width: 50px;
            height: 50px;
            background: linear-gradient(45deg, #2d2d2d, #1e1e1e);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-secondary);
        }
        
        .product-name {
            font-weight: 600;
        }
        
        .price {
            color: var(--primary);
            font-weight: 600;
        }
        
        .quantity {
            background: var(--dark-surface);
            padding: 5px 12px;
            border-radius: 20px;
            font-weight: 600;
        }
        
        .total {
            font-weight: 700;
            color: var(--success);
        }
        
        .grand-total-row {
            background: rgba(255, 255, 255, 0.05);
        }
        
        .grand-total-row td {
            padding: 20px 10px;
            font-weight: 700;
            font-size: 18px;
        }
        
        .grand-total-label {
            text-align: right;
            padding-right: 20px !important;
        }
        
        .grand-total-amount {
            color: var(--primary);
            font-size: 20px;
        }
        
        .checkout-actions {
            background: var(--dark-card);
            border-radius: 12px;
            padding: 25px;
            border: 1px solid var(--border-color);
            height: fit-content;
        }
        
        .action-title {
            font-size: 20px;
            margin-bottom: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .action-title i {
            color: var(--primary);
        }
        
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .pay-btn {
            padding: 15px;
            background: linear-gradient(90deg, var(--success) 0%, #34d399 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .pay-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(16, 185, 129, 0.4);
        }
        
        .continue-btn {
            padding: 15px;
            background: var(--dark-surface);
            color: var(--text-primary);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
            text-align: center;
        }
        
        .continue-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }
        
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: var(--dark-card);
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }
        
        .empty-cart i {
            font-size: 60px;
            color: var(--text-secondary);
            margin-bottom: 20px;
        }
        
        .empty-cart p {
            font-size: 18px;
            margin-bottom: 30px;
            color: var(--text-secondary);
        }
        
        .empty-cart .continue-btn {
            display: inline-flex;
            width: auto;
            padding: 12px 25px;
        }
        
        @media (max-width: 900px) {
            .checkout-container {
                grid-template-columns: 1fr;
            }
        }
        
        @media (max-width: 600px) {
            .cart-table thead {
                display: none;
            }
            
            .cart-table tr {
                display: block;
                margin-bottom: 20px;
                padding-bottom: 20px;
                border-bottom: 1px solid var(--border-color);
            }
            
            .cart-table td {
                display: block;
                text-align: right;
                padding: 10px 15px;
                position: relative;
            }
            
            .cart-table td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                top: 10px;
                font-weight: 600;
                color: var(--text-secondary);
            }
            
            .product-cell {
                justify-content: flex-end;
            }
            
            header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .nav-links {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo">
                <h1>K-Art</h1>
            </div>
            <div class="nav-links">
                <a href="products" class="nav-link"><i class="fas fa-arrow-left"></i> Back to Products</a>
                <a href="cart" class="nav-link"><i class="fas fa-shopping-cart"></i> View Cart</a>
            </div>
        </header>
        
        <h2 class="page-title">Checkout</h2>
        
        <c:if test="${not empty cartItems}">
            <div class="checkout-container">
                <div class="cart-items">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="grandTotal" value="0" />
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td data-label="Product">
                                        <div class="product-cell">
                                            <div class="product-image">
                                                <i class="fas fa-box"></i>
                                            </div>
                                            <div class="product-name">${item.product.name}</div>
                                        </div>
                                    </td>
                                    <td data-label="Price" class="price">Rs ${item.product.price}</td>
                                    <td data-label="Quantity" class="quantity">${item.quantity}</td>
                                    <td data-label="Total" class="total">Rs ${item.product.price * item.quantity}</td>
                                </tr>
                                <c:set var="grandTotal" value="${grandTotal + (item.product.price * item.quantity)}" />
                            </c:forEach>
                            <tr class="grand-total-row">
                                <td colspan="3" class="grand-total-label">Grand Total</td>
                                <td class="grand-total-amount">Rs ${grandTotal}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div class="checkout-actions">
                    <h3 class="action-title"><i class="fas fa-credit-card"></i> Complete Your Purchase</h3>
                    <div class="action-buttons">
                        <form action="cart/clear" method="post">
                            <button type="submit" class="pay-btn">
                                <i class="fas fa-lock"></i> Pay & Clear Cart
                            </button>
                        </form>
                        
                        <a href="products" class="continue-btn">
                            <i class="fas fa-shopping-bag"></i> Continue Shopping
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty cartItems}">
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <p>Your cart is empty.</p>
                <a href="products" class="continue-btn">
                    <i class="fas fa-shopping-bag"></i> Continue Shopping
                </a>
            </div>
        </c:if>
    </div>
</body>
</html>