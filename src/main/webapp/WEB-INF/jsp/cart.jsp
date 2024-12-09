<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
            gap: 20px;
            padding: 20px;
            overflow: hidden;
        }

        .profile {
        background: #e7dfcf;
        padding: 20px;
        border-radius: 8px;
        width: 20rem;
        display: flex;
        flex-direction: column;
        gap: 30px;
        height: 30rem;  
        }

        .products {
            flex-grow: 1;
            height: 100%;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .search-bar {
            width: 40%;
            padding: 10px 20px;
            margin-left: 60%;
        }

        .product-grid {
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); /* Increased from 200px */
            gap: 20px;
            padding: 20px;
            overflow-y: auto;
            height: calc(100% - 60px);
        }

        .product {
            background: #f7e6e6;
            border-radius: 12px;
            overflow: hidden;
            height: 150px; /* Reduced height since it's now horizontal */
            display: flex;
            flex-direction: row; /* Changed from column to row */
            transition: transform 0.3s ease;
        }   

        .product-image {
            width: 150px; /* Fixed width for the image section */
            height: 100%; /* Take full height of parent */
            flex-shrink: 0; /* Prevent image from shrinking */
        }

        .product-details {
            padding: 12px;
            background: #4a4a4a;
            color: white;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Spaces out the content nicely */
        }

        .product:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }



        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 10000;
        }

        .modal.active {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: #E8E2D7;
            padding: 40px;
            border-radius: 12px;
            width: 1000px;
            display: grid;
            grid-template-columns: 1fr 1px 1fr;
            gap: 40px;
            position: relative;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .modal-close {
            position: absolute;
            top: 16px;
            right: 16px;
            width: 30px;
            height: 30px;
            background: #AD4646;
            color: white;
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 20px;
            z-index: 10;
        }

        .modal-close:hover {
            background: #963e3e;
        }

        .product-info {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .product-header {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .product-header h3 {
            font-size: 28px;
            color: #333;
            font-weight: 500;
        }

        .info-label {
            color: #666;
            font-size: 0.95em;
            margin-bottom: 4px;
        }

        .info-value {
            font-size: 1.1em;
            color: #333;
            padding-bottom: 8px;
            border-bottom: 1px solid #ccc;
        }

        .divider {
            width: 1px;
            background-color: #ccc;
            height: auto;
            margin: 0;
        }

        .product-image-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }

        .product-image {
            width: 400px;
            height: 300px;
            border: 2px solid #AD4646;
            border-radius: 8px;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 20px;
        }

        .quantity-control button {
            width: 32px;
            height: 32px;
            border: none;
            background: #AD4646;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            font-size: 18px;
        }

        .quantity-control input {
            width: 60px;
            height: 32px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }

        .btn-add-cart {
            padding: 12px 24px;
            background: #AD4646;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            min-width: 150px;
        }

        .btn-buy-now {
            padding: 12px 24px;
            background: #2B5C2B;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            min-width: 150px;
        }
    </style>
</head>
<body class="flex flex-col">
    <sec:authorize access="isAuthenticated()">
    <div class="h-20 w-full">
        <div class="bg-[#AD4646] w-full flex justify-between items-center h-full px-10">
            <details class="dropdown">
                <summary class="btn w-64 justify-start m-1 bg-transparent hover:bg-transparent border-none hover:border-none shadow-none flex items-center cursor-pointer">
                    <svg width="30" height="30" viewBox="0 0 45 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M22.5 7.5C14.2157 7.5 7.5 14.2157 7.5 22.5C7.5 26.4358 9.01511 30.0185 11.4975 32.6958C11.5912 32.3857 11.7159 32.0811 11.8785 31.7904C12.4297 30.8048 13.1251 29.8934 13.9502 29.0876C14.7782 28.2788 15.7124 27.6001 16.72 27.0639C15.1854 25.5949 14.2259 23.5418 14.2259 21.25C14.2259 16.7213 17.9723 13.125 22.5 13.125C27.0277 13.125 30.7741 16.7213 30.7741 21.25C30.7741 23.5418 29.8146 25.5949 28.28 27.0639C29.2876 27.6001 30.2218 28.2788 31.0498 29.0876C31.8749 29.8934 32.5703 30.8048 33.1215 31.7904C33.2841 32.0811 33.4088 32.3857 33.5025 32.6958C35.9849 30.0185 37.5 26.4358 37.5 22.5C37.5 14.2157 30.7843 7.5 22.5 7.5ZM29.8896 35.5569C29.9624 35.1824 29.9989 34.8308 30 34.5193C30.0018 34.0046 29.9075 33.7261 29.8487 33.6209C29.4726 32.9486 28.9969 32.3243 28.4296 31.7703C26.8644 30.2415 24.7322 29.375 22.5 29.375C20.2678 29.375 18.1356 30.2415 16.5704 31.7703C16.0031 32.3243 15.5274 32.9486 15.1513 33.6209C15.0925 33.7261 14.9982 34.0046 15 34.5193C15.0011 34.8308 15.0376 35.1824 15.1104 35.5569C17.2903 36.7937 19.8103 37.5 22.5 37.5C25.1897 37.5 27.7097 36.7937 29.8896 35.5569ZM22.5 25.625C25.0405 25.625 27.0241 23.6248 27.0241 21.25C27.0241 18.8752 25.0405 16.875 22.5 16.875C19.9595 16.875 17.9759 18.8752 17.9759 21.25C17.9759 23.6248 19.9595 25.625 22.5 25.625ZM3.75 22.5C3.75 12.1447 12.1447 3.75 22.5 3.75C32.8553 3.75 41.25 12.1447 41.25 22.5C41.25 29.1699 37.766 35.0247 32.5275 38.3459C29.6263 40.1853 26.1846 41.25 22.5 41.25C18.8154 41.25 15.3737 40.1853 12.4725 38.3459C7.234 35.0247 3.75 29.1699 3.75 22.5Z" fill="#F2E8C6"/>
                    </svg>  
                    <p class="text-[#F2E8C6] text-base ml-2">${user.name}</p>
                </summary>
                <ul class="menu dropdown-content bg-white rounded-md w-52 shadow-lg cursor-pointer">
                    <li class="hover:bg-slate-200 first:rounded-t-md">
                        <a href="/main" class="block px-5 py-3 text-black text-sm">Product Listing</a>
                    </li>
                    <hr class="border-gray-200"/>
                    <li class="hover:bg-slate-200 last:rounded-b-md">
                        <a id="logout-link" class="block px-5 py-3 text-red-600 text-sm font-bold">Logout</a>
                    </li>
                </ul>
              </details>
              <div>
                <a href="/main"><button class="btn bg-transparent border-none text-[#F2E8C6] hover:text-white shadow-none hover:bg-opacity-10 rounded-3xl px-5">Product Listing</button></a>
                <a href="/cart"><button class="btn bg-transparent border-[#F2E8C6] text-[#F2E8C6] hover:text-black hover:bg-opacity-10 hover:border-[#F2E8C6] rounded-3xl px-5">My Cart</button></a>
              </div>
        </div>
    </div>
    
    <div class="container">
        <div class="profile">
            <div class="flex items-center gap-2">
                <svg width="30" height="30" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M2 3H4.5L6.5 17H17M17 17C15.8954 17 15 17.8954 15 19C15 20.1046 15.8954 21 17 21C18.1046 21 19 20.1046 19 19C19 17.8954 18.1046 17 17 17ZM9 19C9 20.1046 8.10457 21 7 21C5.89543 21 5 20.1046 5 19C5 17.8954 5.89543 17 7 17C8.10457 17 9 17.8954 9 19Z" stroke="#AD4646" stroke-width="1.5"/>
                    <path d="M3.5 5H20L18.5 13H5.5L3.5 5Z" stroke="#AD4646" stroke-width="1.5"/>
                </svg>
                <h3 class="text-black m-0 text-2xl font-bold">Check Out</h3>
            </div>
            <p class="text-lg">Name of Buyer: <c:out value="${user.name}" /></p>
            <p class="text-lg">Mobile No.: <c:out value="${user.mobileNumber}" /></p>
            <p class="text-lg">Subtotal: <c:out value="${product.total}" /></p>
            <div class="flex justify-center mt-auto">
                <button class="bg-[#AD4646] text-white px-4 py-2 rounded-lg btn hover:bg-red-700">Buy Now</button>
            </div>
        </div>

        <div class="flex flex-grow-1 flex-col w-full">
            <div class="rounded-lg hover:rounded-lg flex overflow-hidden w-full h-40 bg-[#f7e6e6] hover:scale-[1.02] transform transition-transform duration-300">
                <div class="w-60 h-full">
                    <img class="h-40" src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp" alt="Product">
                </div>
                <div class="bg-[#4a4a4a] flex w-full p-3 h-full rounded-r-lg hover:rounded-r-lg justify-between flex-col">
                    <div>
                        <h3 class="text-white font-bold mb-2">Product Title</h3>
                        <p class="text-sm">Product description or additional details can go here</p>
                    </div>
                    <div class="flex justify-between items-center">
                        <p class="text-lg font-bold">quantity</p>
                    </div>
                    <div class="flex justify-between items-center">
                        <p class="text-lg font-bold">&#8369;300</p>
                        <button onclick="openProductModal()" class="btn btn-primary bg-opacity-45">Learn now!</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="productModal" class="modal">
        <div class="modal-content">
          <button class="modal-close" onclick="closeProductModal()">&times;</button>
            <div class="product-info">
                <div class="product-header">
                    <svg width="30" height="30" viewBox="0 0 45 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M22.5 7.5C14.2157 7.5 7.5 14.2157 7.5 22.5C7.5 26.4358 9.01511 30.0185 11.4975 32.6958C11.5912 32.3857 11.7159 32.0811 11.8785 31.7904C12.4297 30.8048 13.1251 29.8934 13.9502 29.0876C14.7782 28.2788 15.7124 27.6001 16.72 27.0639C15.1854 25.5949 14.2259 23.5418 14.2259 21.25C14.2259 16.7213 17.9723 13.125 22.5 13.125C27.0277 13.125 30.7741 16.7213 30.7741 21.25C30.7741 23.5418 29.8146 25.5949 28.28 27.0639C29.2876 27.6001 30.2218 28.2788 31.0498 29.0876C31.8749 29.8934 32.5703 30.8048 33.1215 31.7904C33.2841 32.0811 33.4088 32.3857 33.5025 32.6958C35.9849 30.0185 37.5 26.4358 37.5 22.5C37.5 14.2157 30.7843 7.5 22.5 7.5Z" fill="#AD4646"/>
                    </svg>
                    <h3>Product Overview</h3>
                    <button class="modal-close" onclick="closeProductModal()">&times;</button>
                </div>
                <div>
                    <div class="info-label">Product Name:</div>
                    <div id="modalProductName" class="info-value"></div>
                </div>
                <div>
                    <div class="info-label">Product Details:</div>
                    <div id="modalProductDetails" class="info-value"></div>
                </div>
                <div>
                    <div class="info-label">Product Price:</div>
                    <div id="modalProductPrice" class="info-value"></div>
                </div>
                <div>
                    <div class="info-label">Created By:</div>
                    <div id="modalCreatedBy" class="info-value"></div>
                </div>
                <div class="quantity-control">
                    <button onclick="decrementQuantity()">-</button>
                    <input type="number" id="modalQuantity" value="1" min="1" readonly>
                    <button onclick="incrementQuantity()">+</button>
                </div>
            </div>
            
            <div class="divider"></div>
            
            <div class="product-image-section">
                <div class="product-image">
                    <img id="modalProductImage" src="" alt="Product Image">
                </div>
                <div class="action-buttons">
                    <button class="btn-add-cart" onclick="addToCart()">Add to Cart</button>
                    <button class="btn-buy-now" onclick="buyNow()">Buy Now</button>
                </div>
            </div>
        </div>
    </div>
</sec:authorize>
<script>

        function openProductModal() {
            document.getElementById('productModal').classList.add('active');
        }
        function closeProductModal() {
            document.getElementById('productModal').classList.remove('active');
        }

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