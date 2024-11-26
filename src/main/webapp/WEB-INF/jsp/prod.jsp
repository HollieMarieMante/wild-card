<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900">
    <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <c:forEach items="${products}" var="product">
                <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                    <figure>
                        <img
                        src="${product.imageUrl != null ? product.imageUrl : 'https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp'}"
                        alt="${product.name}" />
                    </figure>

                    <div class="card-body p-5">
                        <div class="flex justify-between">
                            <div class="flex flex-col">
                                <h1 class="text-white font-bold">${product.name}</h1>
                                <p>$${product.price}</p>
                            </div>
                            <button class="btn btn-primary bg-opacity-45">Learn now!</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>