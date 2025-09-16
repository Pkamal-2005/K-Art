<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Register | K-Art</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --primary: #7c3aed;
        --primary-dark: #6d28d9;
        --primary-light: #8b5cf6;
        --dark-bg: #121212;
        --dark-surface: #1e1e1e;
        --dark-card: #252525;
        --text-primary: #f5f5f5;
        --text-secondary: #b0b0b0;
        --error: #ef4444;
        --success: #10b981;
        --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
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
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
        overflow: hidden;
    }
    
    /* Animated background elements */
    .bg-animation {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: -1;
        overflow: hidden;
    }
    
    .bg-circle {
        position: absolute;
        border-radius: 50%;
        background: linear-gradient(45deg, var(--primary), transparent);
        opacity: 0.1;
        animation: float 15s infinite ease-in-out;
    }
    
    .bg-circle:nth-child(1) {
        width: 300px;
        height: 300px;
        top: -150px;
        left: -150px;
        animation-delay: 0s;
    }
    
    .bg-circle:nth-child(2) {
        width: 200px;
        height: 200px;
        bottom: -100px;
        right: 20%;
        animation-delay: -5s;
        background: linear-gradient(45deg, var(--primary-light), transparent);
    }
    
    .bg-circle:nth-child(3) {
        width: 150px;
        height: 150px;
        top: 20%;
        right: -75px;
        animation-delay: -10s;
    }
    
    .container {
        width: 100%;
        max-width: 420px;
        margin: 0 auto;
        animation: fadeIn 0.8s ease-out;
        z-index: 1;
    }
    
    .register-card {
        background: var(--dark-card);
        border-radius: 16px;
        padding: 30px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
        border: 1px solid rgba(255, 255, 255, 0.1);
        transition: var(--transition);
        position: relative;
        overflow: hidden;
    }
    
    .register-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 5px;
        background: linear-gradient(90deg, var(--primary), var(--primary-light));
        transform: scaleX(0);
        transform-origin: left;
        transition: transform 0.6s ease;
    }
    
    .register-card:hover::before {
        transform: scaleX(1);
    }
    
    .register-card:hover {
        transform: translateY(-10px) scale(1.01);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6);
    }
    
    .logo {
        text-align: center;
        margin-bottom: 25px;
        transform: translateY(0);
        transition: var(--transition);
    }
    
    .register-card:hover .logo {
        transform: translateY(-5px);
    }
    
    .logo h1 {
        font-size: 32px;
        font-weight: 800;
        background: linear-gradient(90deg, var(--primary) 0%, #a78bfa 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 5px;
        letter-spacing: 1px;
        position: relative;
        display: inline-block;
    }
    
    .logo h1::after {
        content: '';
        position: absolute;
        bottom: -5px;
        left: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, var(--primary) 0%, #a78bfa 100%);
        border-radius: 10px;
        transform: scaleX(0);
        transform-origin: right;
        transition: transform 0.5s ease;
    }
    
    .logo h1:hover::after {
        transform: scaleX(1);
        transform-origin: left;
    }
    
    .logo p {
        color: var(--text-secondary);
        font-size: 14px;
        margin-top: 8px;
    }
    
    .form-group {
        margin-bottom: 25px;
        position: relative;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-size: 14px;
        color: var(--text-secondary);
        transition: var(--transition);
        transform-origin: left;
    }
    
    .form-group:focus-within label {
        color: var(--primary-light);
        transform: translateX(5px);
    }
    
    .input-with-icon {
        position: relative;
    }
    
    .input-with-icon i {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-secondary);
        font-size: 16px;
        transition: var(--transition);
        z-index: 1;
    }
    
    .form-group:focus-within .input-with-icon i {
        color: var(--primary);
        transform: translateY(-50%) scale(1.1);
    }
    
    .input-with-icon input {
        width: 100%;
        padding: 16px 15px 16px 45px;
        border-radius: 12px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        background: var(--dark-surface);
        color: var(--text-primary);
        font-size: 16px;
        transition: var(--transition);
        position: relative;
        z-index: 0;
    }
    
    .input-with-icon input:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(124, 58, 237, 0.3);
        padding: 16px 15px 16px 50px;
    }
    
    .input-with-icon input::placeholder {
        color: var(--text-secondary);
        transition: var(--transition);
    }
    
    .input-with-icon input:focus::placeholder {
        opacity: 0.7;
        transform: translateX(5px);
    }
    
    .toggle-password {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: var(--text-secondary);
        cursor: pointer;
        font-size: 16px;
        transition: var(--transition);
        z-index: 1;
    }
    
    .toggle-password:hover {
        color: var(--primary);
        transform: translateY(-50%) scale(1.1);
    }
    
    .register-btn {
        width: 100%;
        padding: 16px;
        background: linear-gradient(90deg, var(--success) 0%, #34d399 100%);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        margin-top: 10px;
        position: relative;
        overflow: hidden;
    }
    
    .register-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
        transition: 0.5s;
    }
    
    .register-btn:hover::before {
        left: 100%;
    }
    
    .register-btn:hover {
        background: linear-gradient(90deg, #059669 0%, var(--success) 100%);
        transform: translateY(-3px) scale(1.02);
        box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
    }
    
    .register-btn:active {
        transform: translateY(1px) scale(0.99);
    }
    
    .login-link {
        text-align: center;
        margin-top: 20px;
        padding-top: 20px;
        border-top: 1px solid var(--border-color);
    }
    
    .login-link a {
        color: var(--primary);
        text-decoration: none;
        font-weight: 600;
        transition: var(--transition);
    }
    
    .login-link a:hover {
        color: var(--primary-light);
        text-decoration: underline;
    }
    
    .error-message {
        background: rgba(239, 68, 68, 0.1);
        color: var(--error);
        padding: 12px;
        border-radius: 8px;
        border: 1px solid rgba(239, 68, 68, 0.3);
        margin-bottom: 20px;
        text-align: center;
        font-size: 14px;
    }
    
    .success-message {
        background: rgba(16, 185, 129, 0.1);
        color: var(--success);
        padding: 12px;
        border-radius: 8px;
        border: 1px solid rgba(16, 185, 129, 0.3);
        margin-bottom: 20px;
        text-align: center;
        font-size: 14px;
    }

    /* Animations */
    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    @keyframes float {
        0%, 100% {
            transform: translateY(0) rotate(0deg);
        }
        33% {
            transform: translateY(-20px) rotate(10deg);
        }
        66% {
            transform: translateY(20px) rotate(-10deg);
        }
    }
    
    /* Input field animations */
    .input-with-icon input {
        animation: inputSlide 0.6s forwards;
        opacity: 0;
        transform: translateX(-20px);
    }
    
    .form-group:nth-child(1) .input-with-icon input {
        animation-delay: 0.2s;
    }
    
    .form-group:nth-child(2) .input-with-icon input {
        animation-delay: 0.3s;
    }
    
    .form-group:nth-child(3) .input-with-icon input {
        animation-delay: 0.4s;
    }
    
    @keyframes inputSlide {
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    
    /* Responsive design */
    @media (max-width: 480px) {
        .register-card {
            padding: 25px 20px;
        }
        
        .container {
            padding: 10px;
        }
    }
</style>
</head>
<body>
<div class="bg-animation">
    <div class="bg-circle"></div>
    <div class="bg-circle"></div>
    <div class="bg-circle"></div>
</div>

<div class="container">
    <div class="register-card">
        <div class="logo">
            <h1>K-Art</h1>
            <p>Create your account</p>
        </div>


        <form action="register" method="post" id="registerForm">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-with-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" id="username" name="username" placeholder="Choose a username" required 
                           minlength="3" maxlength="50" value="${param.username}">
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-with-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Create a password" required 
                           minlength="6" maxlength="100">
                    <button type="button" class="toggle-password" id="togglePassword">
                        <i class="far fa-eye"></i>
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <div class="input-with-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                    <button type="button" class="toggle-password" id="toggleConfirmPassword">
                        <i class="far fa-eye"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="register-btn">
                <i class="fas fa-user-plus"></i> Create Account
            </button>
        </form>

        <div class="login-link">
            Already have an account? <a href="/">Login here</a>
        </div>
    </div>
</div>

<script>
    // Toggle password visibility
    function setupPasswordToggle(toggleId, passwordId) {
        document.getElementById(toggleId).addEventListener('click', function() {
            const passwordInput = document.getElementById(passwordId);
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    }
    
    setupPasswordToggle('togglePassword', 'password');
    setupPasswordToggle('toggleConfirmPassword', 'confirmPassword');
    
    // Form validation
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        
        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Passwords do not match!');
            return false;
        }
        
        if (password.length < 6) {
            e.preventDefault();
            alert('Password must be at least 6 characters long!');
            return false;
        }
    });
    
    // Add subtle hover effect to the entire card
    const card = document.querySelector('.register-card');
    card.addEventListener('mousemove', function(e) {
        const x = e.clientX - this.getBoundingClientRect().left;
        const y = e.clientY - this.getBoundingClientRect().top;
        
        const centerX = this.offsetWidth / 2;
        const centerY = this.offsetHeight / 2;
        
        const angleX = (y - centerY) / 20;
        const angleY = (centerX - x) / 20;
        
        this.style.transform = `perspective(1000px) rotateX(${angleX}deg) rotateY(${angleY}deg) translateZ(10px)`;
    });
    
    card.addEventListener('mouseleave', function() {
        this.style.transform = '';
    });
</script>
</body>
</html>