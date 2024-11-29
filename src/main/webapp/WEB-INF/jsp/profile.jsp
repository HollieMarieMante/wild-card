<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
            gap: 20px;
            padding: 20px;
            overflow: hidden;
        }

        .profile {
            background: #e7dfcf;
            padding: 20px;
            border-radius: 8px;
            width: 350px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            height: fit-content;
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
            display: flex;
        }

        .product-grid {
            flex: 1;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            padding-bottom: 20px;
            padding-left: 20px;
            padding-right: 20px;
            overflow-y: auto;
            height: calc(100% - 60px);
        }

        .product {
            background: #f7e6e6;
            border-radius: 12px;
            overflow: hidden;
            height: 250px;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease;
        }

        .product:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .product-image {
            height: 150px;
            background: #ddd;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-details {
            padding: 12px;
            background: #4a4a4a;
            color: white;
            flex: 1;
        }
    </style>
</head>


<body class="flex flex-col">
    <sec:authorize access="isAuthenticated()">
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
        <div class="profile mt-20">
            <div class="flex items-center gap-2">
                <svg width="30" height="30" viewBox="0 0 45 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M22.5 7.5C14.2157 7.5 7.5 14.2157 7.5 22.5C7.5 26.4358 9.01511 30.0185 11.4975 32.6958C11.5912 32.3857 11.7159 32.0811 11.8785 31.7904C12.4297 30.8048 13.1251 29.8934 13.9502 29.0876C14.7782 28.2788 15.7124 27.6001 16.72 27.0639C15.1854 25.5949 14.2259 23.5418 14.2259 21.25C14.2259 16.7213 17.9723 13.125 22.5 13.125C27.0277 13.125 30.7741 16.7213 30.7741 21.25C30.7741 23.5418 29.8146 25.5949 28.28 27.0639C29.2876 27.6001 30.2218 28.2788 31.0498 29.0876C31.8749 29.8934 32.5703 30.8048 33.1215 31.7904C33.2841 32.0811 33.4088 32.3857 33.5025 32.6958C35.9849 30.0185 37.5 26.4358 37.5 22.5C37.5 14.2157 30.7843 7.5 22.5 7.5ZM29.8896 35.5569C29.9624 35.1824 29.9989 34.8308 30 34.5193C30.0018 34.0046 29.9075 33.7261 29.8487 33.6209C29.4726 32.9486 28.9969 32.3243 28.4296 31.7703C26.8644 30.2415 24.7322 29.375 22.5 29.375C20.2678 29.375 18.1356 30.2415 16.5704 31.7703C16.0031 32.3243 15.5274 32.9486 15.1513 33.6209C15.0925 33.7261 14.9982 34.0046 15 34.5193C15.0011 34.8308 15.0376 35.1824 15.1104 35.5569C17.2903 36.7937 19.8103 37.5 22.5 37.5C25.1897 37.5 27.7097 36.7937 29.8896 35.5569ZM22.5 25.625C25.0405 25.625 27.0241 23.6248 27.0241 21.25C27.0241 18.8752 25.0405 16.875 22.5 16.875C19.9595 16.875 17.9759 18.8752 17.9759 21.25C17.9759 23.6248 19.9595 25.625 22.5 25.625Z" fill="#AD4646"/>
                </svg>
                <h3 class="text-black m-0">Profile</h3>
            </div>
            <p>Name: ${user.name}</p>
            <p>Course: ${user.course}</p>
            <p>Address: ${user.address}</p>
        </div>

        <div class="products">
            <div class="search-bar items-center w-full justify-between">
                <a href="/add-product"><button class="btn text-[#F2E8C6] bg-[#AD4646] border-none hover:bg-opacity-40 hover:bg-[#AD4646] mr-5 rounded-full" onclick="add_product.showModal()">Sell a product</button></a>
                <label class="input input-bordered bg-transparent border-2 flex items-center gap-2 h-10 rounded-xl">
                    <input type="text" class="grow placeholder:text-opacity-25" placeholder="Search" />
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="h-4 w-4 opacity-70">
                        <path fill-rule="evenodd" d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z" clip-rule="evenodd" />
                    </svg>
                </label>
            </div>

            <div class="product-grid">
                <!-- Example product card -->
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="col-span-full text-center py-10">
                            <h2 class="text-2xl font-bold text-gray-800 mb-4">No products found.</h2>
                            <p class="text-gray-600 mb-6">Start selling now!</p>
                            <a href="/add-product" class="btn btn-primary">Add Your First Product</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="product" items="${products}">
                            <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                                <figure class="h-[60%] w-full items-center justify-center bg-black overflow-hidden">
                                    <img
                                    src= "${product.imageUrl}"
                                    alt="photo unavailable" 
                                    class="cover"/>
                                </figure>

                                <div class="card-body p-5">
                                    <div class="flex justify-between">
                                        <div class="flex flex-col">
                                            <h1 class="text-white  font-bold">${product.productName}</h1>
                                            <p>$<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/></p>
                                            <p>
                                                <c:choose>
                                                    <c:when test="${product.status == -1}">
                                                        <span class="text-yellow-400">Pending</span>
                                                    </c:when>
                                                    <c:when test="${product.status == 0}">
                                                        <span class="text-red-400">Disapproved</span>
                                                    </c:when>
                                                    <c:when test="${product.status == 1}">
                                                        <span class="text-green-400">Approved</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-gray-400">Unknown</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <button class="btn btn-primary w-20 p-0 bg-opacity-45"><p class="text-sm">Edit</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</sec:authorize>
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