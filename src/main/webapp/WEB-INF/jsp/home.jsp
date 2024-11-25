<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/css/styles.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Wild Cart</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-image: url('/assets/covermain.png');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            height: 100vh;
        }
    </style>
</head>
<body>
    <div class="flex justify-center w-dvw h-dvh">
        <section class="flex justify-end w-full h-full">
            <div class="pt-10 mr-10">
                <a href="<c:url value='/login'/>">
                    <button class="btn text-white bg-black rounded-3xl px-10">Login</button>
                </a>
                <a href="<c:url value='/signup'/>">
                    <button class="btn text-white bg-black rounded-3xl px-10">Signup</button>
                </a>
            </div>
        </section>
    </div>
</body>
</html>