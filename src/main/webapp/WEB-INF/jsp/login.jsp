<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link href=" /css/styles.css" ref="stylesheet">
    <script src="httsp://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=poppins:wght@300;400;500;700&display=swap" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Login - WildCart</title>
    <style>
        body {
        font-family: 'poppins', sans-serif;
    }
        .gradient-background {
            background: linear-gradient(to right, #F2E8C6, #800000);
            width: 100dvw;
            height: 100dvh;
            display: grid;
            grid-template-columns: 1fr 1fr;
            align-items: center;
            padding: 0 3.5rem;
            position: fixed;
            top: 0;
            left: 0;    
        }

        .logo-container {
            display: flex;
            justify-content: center;
            align-items: center;
            column-span: 1;
            width: 100%;
            height: 100%;
        }

        .logo {
            width: 400px;
            height: 200px;
        }

        .form-container {
            column-span: 1;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            height: 100%;
            padding-left: 2rem;
            
        }

        .login-form {
            width: 70%;
            background-color: rgba(242, 232, 198, 0.5);
            padding: 2.5rem;
            border-radius: 1.5rem;
            border: 2px solid rgba(0, 0, 0, 0.1);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);

        }

        .input-container {
            width: 90%;
            margin: 0 auto 0.75rem auto;
        }

        .form-input {
            width: 100%;
            height: 30px;
            padding: .5rem;
            border-radius: 0.375rem;
            border: 1px solid rgba(0, 0, 0, 0.2);
            margin-bottom: 0.75rem;
        }

        .form-button {
            width: 80%;
            padding: 1rem;
            background-color: #2563eb;
            color: white;
            border: none;
            border-radius: 0.375rem;
            cursor: pointer;
            margin: 1.25rem 0;
        }

        .form-button:disabled {
            background-color: #93c5fd;
            cursor: not-allowed;
        }

        .separator {
            width: 80%;
            height: 1px;
            background-color: currentColor;
            margin: 1.25rem auto;
        }

        .error-message {
            color: #ef4444;
            font-size: 0.875rem;
            margin-bottom: 0.75rem;
            text-align: center;
        }

        .signup-link {
            text-align: center;
        }

        .signup-link a {
            color: #1e40af;
            text-decoration: none;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    
    <div class="gradient-background">
        <div class="logo-container">
            <img src='/assets/wildcart-logos.png' alt="Logo" class="w-32 h-32">
        </div>
        
        <div class="form-container">
            <div class="login-form">
                <h1 style="font-weight: bold; font-size: 1.25rem; margin-bottom: 1.25rem;">Login</h1>
                
                <form action="/login" method="post">
                    <div class="input-container">
                        <input type="email" 
                               name="username" 
                               placeholder="Email" 
                               required 
                               class="form-input"
                               value="${param.email}">
                               
                        <input type="password" 
                               name="password" 
                               placeholder="Password" 
                               required 
                               class="form-input">
                               <div class="error-message">
                                <c:if test="${param.error == 'blocked'}">
                                    <p>Your account is currently blocked.Please contact support</p>
                                </c:if>
                                <c:if test="${param.error == 'true'}">
                                    <p>Invalid username or password. Please try again.</p>
                                </c:if>
                            </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <di v style="display: flex; flex-direction: column; align-items: center;">
                        
                        <button type="submit" class="form-button">
                            Login
                        </button>

                        <div class="forgetpass-link">
                            <a href="/forgetpass">forgot password?</a>
                        </div>
                        <div class="separator"></div>
                        
                        <div class="signup-link">
                            <p>Don't have an account yet? <a href="/signup">Sign up here</a>.</p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>