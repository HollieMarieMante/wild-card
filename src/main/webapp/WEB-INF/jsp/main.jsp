<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/css/styles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=poppins:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com">
    </script>
    <style>
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
    </style>
    <title>Wild Cart</title>
</head>
<body>
    <script>
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

        // Initialize button states on page load
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input[type="number"]');
            inputs.forEach(updateButtonStates);
        });
    </script>

    <div class="flex flex-col items-center w-dvw h-dvh bg-[#F2E8C6]">
        <%@ include file="header.jsp" %>

        <div class="w-full h-[89%] flex flex-col">

            <div class="w-full flex h-14 shadow-2xl justify-end px-20 items-center">
                <label class="input input-bordered bg-transparent border-2 flex items-center gap-2 h-10 rounded-xl">
                    <input type="text" class="grow placeholder:text-opacity-25" placeholder="Search" />
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 16 16"
                      fill="currentColor"
                      class="h-4 w-4 opacity-70">
                      <path
                        fill-rule="evenodd"
                        d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
                        clip-rule="evenodd" />
                    </svg>
                  </label>
            </div>
            <div class="w-full border-2 flex justify-center items-center px-5 h-full overflow-y-auto">
                <div class="w-full h-[95%] grid grid-cols-4 gap-5 px-5">

                    <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                        <figure>
                            <img
                            src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                            alt="car!" />
                        </figure>

                        <div class="card-body p-5">
                            <div class="flex justify-between">
                                <div class="flex flex-col">
                                    <h1 class="text-white font-bold">Product Title</h1>
                                    <p>$300</p>
                                </div>
                                <button onclick="product_modal.showModal()" class="btn btn-primary bg-opacity-45">Learn now!</button>
                            </div>
                        </div>
                    </div>

                    <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                        <figure>
                            <img
                            src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                            alt="car!" />
                        </figure>

                        <div class="card-body p-5">
                            <div class="flex justify-between">
                                <div class="flex flex-col">
                                    <h1 class="text-white font-bold">Product Title</h1>
                                    <p>$300</p>
                                </div>
                                <button class="btn btn-primary bg-opacity-45">Learn now!</button>
                            </div>
                        </div>
                    </div>

                    <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                        <figure>
                            <img
                            src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                            alt="car!" />
                        </figure>

                        <div class="card-body p-5">
                            <div class="flex justify-between">
                                <div class="flex flex-col">
                                    <h1 class="text-white font-bold">Product Title</h1>
                                    <p>$300</p>
                                </div>
                                <button class="btn btn-primary bg-opacity-45">Learn now!</button>
                            </div>
                        </div>
                    </div>

                    <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                        <figure>
                            <img
                            src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                            alt="car!" />
                        </figure>

                        <div class="card-body p-5">
                            <div class="flex justify-between">
                                <div class="flex flex-col">
                                    <h1 class="text-white font-bold">Product Title</h1>
                                    <p>$300</p>
                                </div>
                                <button class="btn btn-primary bg-opacity-45">Learn now!</button>
                            </div>
                        </div>
                    </div>

                    <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                        <figure>
                            <img
                            src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                            alt="car!" />
                        </figure>

                        <div class="card-body p-5">
                            <div class="flex justify-between">
                                <div class="flex flex-col">
                                    <h1 class="text-white font-bold">Product Title</h1>
                                    <p>$300</p>
                                </div>
                                <button class="btn btn-primary bg-opacity-45">Learn now!</button>
                            </div>
                        </div>
                    </div>

                    <div class="transform transition-transform duration-300 hover:scale-105 hover:shadow-2xl overflow-hidden card col-span-1 h-[17rem] mt-5 shadow-xl rounded-xl bg-[#4D4848] inline-block">
                        <figure>
                            <img
                            src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                            alt="car!" />
                        </figure>

                        <div class="card-body p-5">
                            <div class="flex justify-between">
                                <div class="flex flex-col">
                                    <h1 class="text-white font-bold">Product Title</h1>
                                    <p>$300</p>
                                </div>
                                <button class="btn btn-primary bg-opacity-45">Learn now!</button>
                            </div>
                        </div>
                    </div>
                      
                </div>
            </div>
        </div>
    </div>
</body>
</html>