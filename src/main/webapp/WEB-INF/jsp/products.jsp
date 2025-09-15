<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products | K-Art</title>
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
            max-width: 1200px;
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
        
        .cart-link {
            background: var(--primary);
            padding: 10px 15px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
        }
        
        .cart-link:hover {
            background: var(--primary-dark);
            color: white;
        }
        
        .page-title {
            margin-bottom: 25px;
            font-size: 24px;
            font-weight: 600;
        }
        
        .search-container {
            margin-bottom: 25px;
            position: relative;
        }
        
        .search-input {
            width: 100%;
            padding: 14px 20px;
            padding-left: 45px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            background: var(--dark-surface);
            color: var(--text-primary);
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.2);
        }
        
        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }
        
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .product-card {
            background: var(--dark-card);
            border-radius: 12px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid var(--border-color);
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        }
        
        .product-image {
            height: 200px;
            background: linear-gradient(45deg, #2d2d2d, #1e1e1e);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-secondary);
            font-size: 50px;
        }
        
        .product-info {
            padding: 20px;
        }
        
        .product-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .product-price {
            color: var(--primary);
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .add-to-cart-form {
            display: flex;
            gap: 10px;
        }
        
        .quantity-input {
            width: 70px;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            background: var(--dark-surface);
            color: var(--text-primary);
            text-align: center;
        }
        
        .add-to-cart-btn {
            flex: 1;
            padding: 10px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-weight: 600;
        }
        
        .add-to-cart-btn:hover {
            background: var(--primary-dark);
        }
        
        .view-cart-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 28px;
            background: linear-gradient(90deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .view-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(124, 58, 237, 0.4);
        }
        
        .no-products {
            text-align: center;
            padding: 40px;
            color: var(--text-secondary);
            font-size: 18px;
            grid-column: 1 / -1;
        }
        
        @media (max-width: 768px) {
            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
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
        
        @media (max-width: 480px) {
            .products-grid {
                grid-template-columns: 1fr;
            }
            
            .nav-links {
                flex-direction: column;
                gap: 10px;
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
                <a href="cart" class="nav-link cart-link"><i class="fas fa-shopping-cart"></i> View Cart</a>
            </div>
        </header>
        
        <h2 class="page-title">Available Products</h2>
        
        <div class="search-container">
            <i class="fas fa-search search-icon"></i>
            <input type="text" id="searchInput" class="search-input" placeholder="Search products by name..." />
        </div>
        
        <div class="products-grid" id="productsGrid">
            <c:forEach var="product" items="${products}">
                <div class="product-card" data-name="${product.name.toLowerCase()}">
                    <div class="product-image">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="product-info">
                        <h3 class="product-name">${product.name}</h3>
                        <div class="product-price">Rs ${product.price}</div>
                        <form action="cart/add" method="post" class="add-to-cart-form">
                            <input type="hidden" name="productId" value="${product.id}"/>
                            <input type="number" name="quantity" value="1" min="1" class="quantity-input"/>
                            <button type="submit" class="add-to-cart-btn">
                                <i class="fas fa-cart-plus"></i> Add
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
        
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const productCards = document.querySelectorAll('.product-card');
            
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase().trim();
                
                productCards.forEach(card => {
                    const productName = card.getAttribute('data-name');
                    
                    if (productName.includes(searchTerm)) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
                
                // Check if all products are hidden
                const visibleProducts = document.querySelectorAll('.product-card[style="display: block"]');
                let noProductsMessage = document.querySelector('.no-products');
                
                if (visibleProducts.length === 0 && searchTerm !== '') {
                    if (!noProductsMessage) {
                        noProductsMessage = document.createElement('div');
                        noProductsMessage.className = 'no-products';
                        noProductsMessage.innerHTML = '<i class="fas fa-search" style="font-size: 40px; margin-bottom: 15px;"></i><p>No products found matching your search.</p>';
                        document.getElementById('productsGrid').appendChild(noProductsMessage);
                    }
                } else if (noProductsMessage) {
                    noProductsMessage.remove();
                }
            });
        });
    </script>
</body>
</html>
