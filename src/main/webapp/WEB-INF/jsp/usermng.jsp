<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.tailwindcss.com" rel="stylesheet" />
    <title>User Management</title>
  </head>
  <body class="bg-gray-100 font-sans leading-normal tracking-normal">
    <div class="container mx-auto mt-10">
      <h1 class="text-2xl font-bold text-center mb-6">User Management</h1>
      <table class="table-auto w-full border-collapse border border-gray-400">
        <thead class="bg-gray-200">
          <tr>
            <th class="border border-gray-400 px-4 py-2 text-left">Name</th>
            <th class="border border-gray-400 px-4 py-2 text-left">Email</th>
            <th class="border border-gray-400 px-4 py-2 text-left">Course</th>
            <th class="border border-gray-400 px-4 py-2 text-left">Status</th>
            <th class="border border-gray-400 px-4 py-2 text-center">Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="user" items="${users}">
            <tr class="bg-white hover:bg-gray-100">
              <td class="border border-gray-400 px-4 py-2">${user.name}</td>
              <td class="border border-gray-400 px-4 py-2">${user.email}</td>
              <td class="border border-gray-400 px-4 py-2">${user.course}</td>
              <td class="border border-gray-400 px-4 py-2">
                <c:choose>
                  <c:when test="${user.roles.contains('BLOCK')}">
                    <span class="text-red-600 font-bold">Blocked</span>
                  </c:when>
                  <c:otherwise>
                    <span class="text-green-600 font-bold">Active</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="border border-gray-400 px-4 py-2 text-center">
                <c:choose>
                  <c:when test="${user.roles.contains('BLOCK')}">
                    <form action="/unblock" method="post">
                      <input type="hidden" name="userId" value="${user.userId}" />
                      <button
                        type="submit"
                        class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600"
                      >
                        Unblock
                      </button>
                    </form>
                  </c:when>
                  <c:otherwise>
                    <form action="/block" method="post">
                      <input type="hidden" name="userId" value="${user.userId}" />
                      <button
                        type="submit"
                        class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
                      >
                        Block
                      </button>
                    </form>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </body>
</html>