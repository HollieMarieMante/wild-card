<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/css/styles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=poppins:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Profile</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        html, body {
            height: 100vh;
            width: 100vw;
            overflow: hidden;
            font-family: Arial, sans-serif;
            background-color: #f9f3e8;
        }
        
        body {
            font-family: 'poppins', sans-serif;
        }
        /* Remove spinner arrows from number input */
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        input[type=number] {
            -moz-appearance: textfield;
        }

        /* Custom styles for dropdown */
        .dropdown summary::-webkit-details-marker {
            display: none;
        }
        
        .dropdown[open] .dropdown-content {
            animation: slideDown 0.2s ease-out;
        }
        
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Ensure dropdown stays on top */
        .dropdown {
            position: relative;
            z-index: 9999;
        }
        
        .dropdown-content {
            position: absolute;
            right: 0;
        }

        header {
            background-color: #AD4646;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 11vh;
        }

        .container {
            height: 89vh;
            width: 100vw;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            overflow: hidden;
        }

        .profile-container {
            background: #e7dfcf;
            padding: 30px;
            border-radius: 8px;
            width: 1000px;
            display: flex;
            gap: 40px;
            height: fit-content;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .profile-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-picture {
            width: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            padding-top: 45px;
        }

        .info-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .info-group label {
            font-size: 0.95em;
            color: #666;
            font-weight: 500;
        }

        .info-group .value {
            font-size: 1.1em;
            color: #333;
            font-weight: 400;
            padding: 8px 0;
            border-bottom: 1px solid #ccc;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 10px;
        }

        .profile-header h3 {
            font-size: 1.5em;
            font-weight: 500;
            color: #333;
        }

        .picture-placeholder {
            width: 300px;
            height: 300px;
            background-color: #ddd;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 2px solid #AD4646;
        }

        .buttons-container {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 30px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 1em;
            transition: all 0.3s ease;
            min-width: 140px;
        }

        .btn-primary {
            background-color: #AD4646;
            color: white;
        }

        .btn-primary:hover {
            background-color: #963e3e;
        }

        .btn-secondary {
            background-color: #2b5c2b;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #224422;
        }

        .divider {
            width: 1px;
            background-color: #ccc;
            margin: 0 20px;
        }
    </style>

    <script>

        document.addEventListener('DOMContentLoaded', function() {
                const inputs = document.querySelectorAll('input[type="number"]');
                inputs.forEach(updateButtonStates);
            });
            
        function incrementQuantity(button) {
            const input = button.parentElement.querySelector('input');
            const currentValue = parseInt(input.value) || 0;
            const maxValue = parseInt(input.getAttribute('max'));
            
            if (currentValue < maxValue) {
                input.value = currentValue + 1;
                updateButtonStates(input);
                // Trigger change event for form submission
                input.dispatchEvent(new Event('change'));
            }
        }

        function decrementQuantity(button) {
            const input = button.parentElement.querySelector('input');
            const currentValue = parseInt(input.value) || 0;
            const minValue = parseInt(input.getAttribute('min'));
            
            if (currentValue > minValue) {
                input.value = currentValue - 1;
                updateButtonStates(input);
                // Trigger change event for form submission
                input.dispatchEvent(new Event('change'));
            }
        }

        function validateQuantity(input) {
            const value = parseInt(input.value) || 0;
            const minValue = parseInt(input.getAttribute('min'));
            const maxValue = parseInt(input.getAttribute('max'));
            
            // Ensure value is within bounds
            input.value = Math.min(Math.max(value, minValue), maxValue);
            updateButtonStates(input);
        }

        function updateButtonStates(input) {
            const value = parseInt(input.value) || 0;
            const minValue = parseInt(input.getAttribute('min'));
            const maxValue = parseInt(input.getAttribute('max'));
            
            const decrementBtn = input.parentElement.querySelector('button:first-child');
            const incrementBtn = input.parentElement.querySelector('button:last-child');
            
            decrementBtn.disabled = value <= minValue;
            incrementBtn.disabled = value >= maxValue;
        }
    
        function addToCart(productId) {
        const quantity = document.getElementById('quantity' + productId).value;
        // Add your logic here to add the product to the cart
        console.log(`Added product ${productId} to cart with quantity ${quantity}`);
        }
    </script>
</head>
<body class="flex flex-col">

    <div class="h-20 w-full">
        <div class="bg-[#AD4646] w-full flex justify-between items-center h-full px-10">
            <details class="dropdown">
                <summary class="btn m-1 bg-transparent hover:bg-transparent border-none hover:border-none shadow-none flex items-center cursor-pointer">
                    <svg width="30" height="30" viewBox="0 0 45 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M22.5 7.5C14.2157 7.5 7.5 14.2157 7.5 22.5C7.5 26.4358 9.01511 30.0185 11.4975 32.6958C11.5912 32.3857 11.7159 32.0811 11.8785 31.7904C12.4297 30.8048 13.1251 29.8934 13.9502 29.0876C14.7782 28.2788 15.7124 27.6001 16.72 27.0639C15.1854 25.5949 14.2259 23.5418 14.2259 21.25C14.2259 16.7213 17.9723 13.125 22.5 13.125C27.0277 13.125 30.7741 16.7213 30.7741 21.25C30.7741 23.5418 29.8146 25.5949 28.28 27.0639C29.2876 27.6001 30.2218 28.2788 31.0498 29.0876C31.8749 29.8934 32.5703 30.8048 33.1215 31.7904C33.2841 32.0811 33.4088 32.3857 33.5025 32.6958C35.9849 30.0185 37.5 26.4358 37.5 22.5C37.5 14.2157 30.7843 7.5 22.5 7.5ZM29.8896 35.5569C29.9624 35.1824 29.9989 34.8308 30 34.5193C30.0018 34.0046 29.9075 33.7261 29.8487 33.6209C29.4726 32.9486 28.9969 32.3243 28.4296 31.7703C26.8644 30.2415 24.7322 29.375 22.5 29.375C20.2678 29.375 18.1356 30.2415 16.5704 31.7703C16.0031 32.3243 15.5274 32.9486 15.1513 33.6209C15.0925 33.7261 14.9982 34.0046 15 34.5193C15.0011 34.8308 15.0376 35.1824 15.1104 35.5569C17.2903 36.7937 19.8103 37.5 22.5 37.5C25.1897 37.5 27.7097 36.7937 29.8896 35.5569ZM22.5 25.625C25.0405 25.625 27.0241 23.6248 27.0241 21.25C27.0241 18.8752 25.0405 16.875 22.5 16.875C19.9595 16.875 17.9759 18.8752 17.9759 21.25C17.9759 23.6248 19.9595 25.625 22.5 25.625ZM3.75 22.5C3.75 12.1447 12.1447 3.75 22.5 3.75C32.8553 3.75 41.25 12.1447 41.25 22.5C41.25 29.1699 37.766 35.0247 32.5275 38.3459C29.6263 40.1853 26.1846 41.25 22.5 41.25C18.8154 41.25 15.3737 40.1853 12.4725 38.3459C7.234 35.0247 3.75 29.1699 3.75 22.5Z" fill="#F2E8C6"/>
                    </svg>  
                    <p class="text-[#F2E8C6] text-base ml-2">${user.name}</p>
                </summary>
                <ul class="menu dropdown-content bg-white rounded-md w-52 shadow-lg cursor-pointer">
                    <li class="hover:bg-slate-200 first:rounded-t-md">
                        <a href="/profile" class="block px-5 py-3 text-black text-sm">Profile</a>
                    </li>
                    <hr class="border-gray-200"/>
                    <li class="hover:bg-slate-200 last:rounded-b-md">
                        <a id="logout-link" class="block px-5 py-3 text-red-600 text-sm font-bold">Logout</a>
                    </li>
                </ul>
              </details>
              <div>
                
              </div>
              <div>
                <a href="/main"><button class="btn bg-transparent border-none text-[#F2E8C6] hover:text-white shadow-none hover:bg-opacity-10 rounded-3xl px-5">Product Listing</button></a>
                <a href="/cart"><button class="btn bg-transparent border-[#F2E8C6] text-[#F2E8C6] hover:text-black hover:bg-opacity-10 hover:border-[#F2E8C6] rounded-3xl px-5">My Cart</button></a>
              </div>
        </div>
    </div>

    <div class="container">
        <div class="profile-container">
            <div class="profile-info">
                <div class="profile-header">
                    <svg width="30" height="30" viewBox="0 0 45 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M22.5 7.5C14.2157 7.5 7.5 14.2157 7.5 22.5C7.5 26.4358 9.01511 30.0185 11.4975 32.6958C11.5912 32.3857 11.7159 32.0811 11.8785 31.7904C12.4297 30.8048 13.1251 29.8934 13.9502 29.0876C14.7782 28.2788 15.7124 27.6001 16.72 27.0639C15.1854 25.5949 14.2259 23.5418 14.2259 21.25C14.2259 16.7213 17.9723 13.125 22.5 13.125C27.0277 13.125 30.7741 16.7213 30.7741 21.25C30.7741 23.5418 29.8146 25.5949 28.28 27.0639C29.2876 27.6001 30.2218 28.2788 31.0498 29.0876C31.8749 29.8934 32.5703 30.8048 33.1215 31.7904C33.2841 32.0811 33.4088 32.3857 33.5025 32.6958C35.9849 30.0185 37.5 26.4358 37.5 22.5C37.5 14.2157 30.7843 7.5 22.5 7.5ZM29.8896 35.5569C29.9624 35.1824 29.9989 34.8308 30 34.5193C30.0018 34.0046 29.9075 33.7261 29.8487 33.6209C29.4726 32.9486 28.9969 32.3243 28.4296 31.7703C26.8644 30.2415 24.7322 29.375 22.5 29.375C20.2678 29.375 18.1356 30.2415 16.5704 31.7703C16.0031 32.3243 15.5274 32.9486 15.1513 33.6209C15.0925 33.7261 14.9982 34.0046 15 34.5193C15.0011 34.8308 15.0376 35.1824 15.1104 35.5569C17.2903 36.7937 19.8103 37.5 22.5 37.5C25.1897 37.5 27.7097 36.7937 29.8896 35.5569ZM22.5 25.625C25.0405 25.625 27.0241 23.6248 27.0241 21.25C27.0241 18.8752 25.0405 16.875 22.5 16.875C19.9595 16.875 17.9759 18.8752 17.9759 21.25C17.9759 23.6248 19.9595 25.625 22.5 25.625Z" fill="#AD4646"/>
                    </svg>
                    <h3>Product Overview</h3>
                </div>
                <div class="info-group">
                    <label>Product Name:</label>
                    <div class="value">${product.productName}</div>
                </div>
                <div class="info-group">
                    <label>Product Details:</label>
                    <div class="value">${product.details}</div>
                </div>
                <div class="info-group">
                    <label>Product Price:</label>
                    <div class="value">&#8369;<fmt:formatNumber value="${product.price}" maxFractionDigits="0" /></div>
                </div>

                <div class="flex items-center">
                    <button class="btn btn-square btn-sm" onclick="decrementQuantity(this)">-</button>
                    <input type="number" id="quantity" name="quantity" class="input input-bordered w-16 mx-2 text-center" value="1" min="1" readonly>
                    <button class="btn btn-square btn-sm" onclick="incrementQuantity(this)">+</button>
                </div>                  
            </div>
            
            <div class="divider"></div>
            
            <div class="profile-picture">
                <div class="picture-placeholder">
                    <img src="${product.imageUrl}" alt="Profile Picture Placeholder" />
                </div>
                <div class="buttons-container">
                    <button class="btn btn-primary">Add to Cart</button>
                    <button class="btn btn-secondary">Buy Now</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        (function() {
            window.history.pushState(null, document.title, location.href);
            window.addEventListener('popstate', function(event) {
                window.history.pushState(null, document.title, location.href);
            });
        })();

        document.getElementById('logout-link').addEventListener('click', function(e) {
        e.preventDefault();
        var form = document.createElement('form');
        form.method = 'post';
        form.action = '${pageContext.request.contextPath}/logout';
        
        var csrfInput = document.createElement('input');
        csrfInput.type = 'hidden';
        csrfInput.name = '${_csrf.parameterName}';
        csrfInput.value = '${_csrf.token}';
        
        form.appendChild(csrfInput);
        document.body.appendChild(form);
        form.submit();
    });
    </script>
</body>
</html>