<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/css/styles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=poppins:wght@300;400;500;700&display=swap" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Wild Cart</title>
    <style>
        body {
            font-family: "poppins", sans-serif;
        }
    </style>
</head>
<body>
    <div class="flex justify-center w-dvw h-dvh bg-[#F2E8C6] items-center flex-col">
        <img src="/assets/error.png" alt="image unavailable" class="w-40 h-40 mb-2"/>
        <h1 class="text-[#AD4646] font-semibold mb-5">Unknown Error</h1>
        <p class="text-[#AD4646] font-bold">Go back to <span class="text-blue-700 underline"><a href="/login">Login</a>.</span></p>
    </div>
</body>
</html>