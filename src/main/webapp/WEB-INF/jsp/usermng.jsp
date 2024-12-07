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
    <title>User Management</title>
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

        
    </style>
</head>
<body class="flex flex-col">
    <sec:authorize access="isAuthenticated()">
    <div class="h-20 w-full">
        <div class="bg-[#AD4646] w-full flex justify-between items-center h-full px-10">
            <details class="dropdown">
                <summary class="btn w-64 m-1 bg-transparent hover:bg-transparent border-none hover:border-none shadow-none flex justify-start cursor-pointer">
                    <svg width="30" height="30" viewBox="0 0 45 45" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M22.5 7.5C14.2157 7.5 7.5 14.2157 7.5 22.5C7.5 26.4358 9.01511 30.0185 11.4975 32.6958C11.5912 32.3857 11.7159 32.0811 11.8785 31.7904C12.4297 30.8048 13.1251 29.8934 13.9502 29.0876C14.7782 28.2788 15.7124 27.6001 16.72 27.0639C15.1854 25.5949 14.2259 23.5418 14.2259 21.25C14.2259 16.7213 17.9723 13.125 22.5 13.125C27.0277 13.125 30.7741 16.7213 30.7741 21.25C30.7741 23.5418 29.8146 25.5949 28.28 27.0639C29.2876 27.6001 30.2218 28.2788 31.0498 29.0876C31.8749 29.8934 32.5703 30.8048 33.1215 31.7904C33.2841 32.0811 33.4088 32.3857 33.5025 32.6958C35.9849 30.0185 37.5 26.4358 37.5 22.5C37.5 14.2157 30.7843 7.5 22.5 7.5ZM29.8896 35.5569C29.9624 35.1824 29.9989 34.8308 30 34.5193C30.0018 34.0046 29.9075 33.7261 29.8487 33.6209C29.4726 32.9486 28.9969 32.3243 28.4296 31.7703C26.8644 30.2415 24.7322 29.375 22.5 29.375C20.2678 29.375 18.1356 30.2415 16.5704 31.7703C16.0031 32.3243 15.5274 32.9486 15.1513 33.6209C15.0925 33.7261 14.9982 34.0046 15 34.5193C15.0011 34.8308 15.0376 35.1824 15.1104 35.5569C17.2903 36.7937 19.8103 37.5 22.5 37.5C25.1897 37.5 27.7097 36.7937 29.8896 35.5569ZM22.5 25.625C25.0405 25.625 27.0241 23.6248 27.0241 21.25C27.0241 18.8752 25.0405 16.875 22.5 16.875C19.9595 16.875 17.9759 18.8752 17.9759 21.25C17.9759 23.6248 19.9595 25.625 22.5 25.625ZM3.75 22.5C3.75 12.1447 12.1447 3.75 22.5 3.75C32.8553 3.75 41.25 12.1447 41.25 22.5C41.25 29.1699 37.766 35.0247 32.5275 38.3459C29.6263 40.1853 26.1846 41.25 22.5 41.25C18.8154 41.25 15.3737 40.1853 12.4725 38.3459C7.234 35.0247 3.75 29.1699 3.75 22.5Z" fill="#F2E8C6"/>
                    </svg>  
                    <p class="text-[#F2E8C6] text-base ml-2">${user.name}</p>
                </summary>
                <ul class="menu dropdown-content bg-white rounded-md w-52 shadow-lg cursor-pointer">
                    <li class="hover:bg-slate-200 last:rounded-b-md">
                        <a id="logout-link" class="block px-5 py-3 text-red-600 text-sm font-bold">Logout</a>
                    </li>
                </ul>
              </details>
              <div>
                <a href="/admin"><button class="btn bg-transparent border-[#F2E8C6] text-[#F2E8C6] hover:text-black hover:bg-opacity-10 hover:border-[#F2E8C6] rounded-3xl px-5">Admin</button></a>
              </div>
        </div>
    </div>
    
    <div class="p-8">
      <div class="flex items-center gap-4 mb-6">
          <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#AD4646" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
              <circle cx="8.5" cy="7" r="4"/>
              <line x1="20" y1="8" x2="20" y2="14"/>
              <line x1="23" y1="11" x2="17" y2="11"/>
          </svg>
          <h2 class="text-2xl font-bold text-[#AD4646]">User Management</h2>
      </div>
      
      <div class="overflow-x-auto bg-white rounded-lg shadow">
          <table class="w-full border-collapse">
              <thead>
                  <tr class="bg-gray-50">
                      <th class="px-6 py-4 text-left text-sm font-semibold text-gray-600">Name</th>
                      <th class="px-6 py-4 text-left text-sm font-semibold text-gray-600">Email</th>
                      <th class="px-6 py-4 text-left text-sm font-semibold text-gray-600">Course</th>
                      <th class="px-6 py-4 text-left text-sm font-semibold text-gray-600">Status</th>
                      <th class="px-6 py-4 text-center text-sm font-semibold text-gray-600">Actions</th>
                  </tr>
              </thead>
              <tbody class="divide-y divide-gray-200">
                  <c:forEach var="user" items="${users}">
                    <c:if test="${user.roles != 'SUPER_ADMIN'}">
                      <tr class="hover:bg-gray-50">
                          <td class="px-6 py-4 text-sm text-gray-800">${user.name}</td>
                          <td class="px-6 py-4 text-sm text-gray-800">${user.email}</td>
                          <td class="px-6 py-4 text-sm text-gray-800">${user.course}</td>
                          <td class="px-6 py-4">
                              <c:choose>
                                  <c:when test="${user.roles.contains('BLOCK')}">
                                      <span class="inline-flex px-2 py-1 text-xs font-semibold leading-5 text-red-800 bg-red-100 rounded-full">
                                          Blocked
                                      </span>
                                  </c:when>
                                  <c:otherwise>
                                      <span class="inline-flex px-2 py-1 text-xs font-semibold leading-5 text-green-800 bg-green-100 rounded-full">
                                          Active
                                      </span>
                                  </c:otherwise>
                              </c:choose>
                          </td>
                          <td class="px-6 py-4 text-center">
                              <c:choose>
                                  <c:when test="${user.roles.contains('BLOCK')}">
                                      <form action="/unblock" method="post" class="inline">
                                          <input type="hidden" name="userId" value="${user.userId}" />
                                          <button type="submit" class="px-3 py-1 text-sm text-white bg-green-500 hover:bg-green-600 rounded">
                                              Unblock
                                          </button>
                                      </form>
                                  </c:when>
                                  <c:otherwise>
                                      <form action="/block" method="post" class="inline">
                                          <input type="hidden" name="userId" value="${user.userId}" />
                                          <button type="submit" class="px-3 py-1 text-sm text-white bg-red-500 hover:bg-red-600 rounded">
                                              Block
                                          </button>
                                      </form>
                                  </c:otherwise>
                              </c:choose>
                          </td>
                      </tr>
                    </c:if> 
                  </c:forEach>
              </tbody>
          </table>
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