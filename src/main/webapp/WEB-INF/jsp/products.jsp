<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Your existing head content -->
</head>
<body>
    <div class="flex flex-col items-center w-dvw h-dvh bg-[#F2E8C6]">
        <div class="w-full h-[89%] flex flex-col">
            <div class="w-full flex h-14 shadow-2xl justify-end px-20 items-center">
                <!-- Your existing search bar -->
            </div>
            <div class="w-full border-2 flex justify-center items-center px-5 h-full overflow-y-auto">
                <div class="w-full h-[95%] grid grid-cols-4 gap-5 px-5">
                    
                    <c:forEach items="${products}" var="product">
                        <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                            <figure>
                                
                            </figure>

                            <div class="card-body p-5">
                                <div class="flex justify-between">
                                    <div class="flex flex-col">
                                        <h1 class="text-black font-bold">${product.name}</h1>
                                        <p>$${product.price}</p>
                                    </div>
                                    <button onclick="product_modal.showModal()" class="btn btn-primary bg-opacity-45">Learn now!</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                      
                </div>
            </div>
        </div>
    </div>
    <!-- Your existing scripts -->
</body>
</html>