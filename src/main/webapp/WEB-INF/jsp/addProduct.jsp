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
    </style>
</head>
<body>
    <sec:authorize access="isAuthenticated()">
    <div class="flex flex-col items-center w-dvw h-dvh bg-[#F2E8C6]">

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

        <div class="flex justify-center w-[80%] h-[80%] bg-[#AD4646] border-2 border-gray-800 bg-opacity-50 shadow-lg mt-6 rounded-3xl">
            <form id="productForm" class="grid grid-cols-2 w-[80%] h-[90%]">
                
                <div class="col-span-1">
                    <div class="form-control mt-10 w-full max-w-xs">
                        <label for="file-upload" class="label">
                          <span class="label-text text-gray-800">Pick a file</span>
                        </label>
                        <div id="drop-zone" class="flex justify-center items-center w-full h-32 px-4 transition bg-white border-2 border-gray-300 border-dashed rounded-md appearance-none cursor-pointer hover:border-gray-400 focus:outline-none">
                          <span id="file-name" class="flex items-center space-x-2">
                            <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 text-gray-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                              <path stroke-linecap="round" stroke-linejoin="round" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                            </svg>
                            <span class="font-medium text-gray-600">
                              Drop file here or click to select
                            </span>
                          </span>
                        </div>
                        <input type="file" id="file-upload" class="hidden" />
                        <input type="hidden" id="file-path" name="filePath" />
                      </div>

                      <div id="image-preview" class="mt-4 hidden">
                        <div class="w-80 h-60 overflow-hidden rounded-lg shadow-lg">
                          <img id="preview-image" class="w-full h-full object-cover" src="" alt="Image preview" />
                        </div>
                      </div>
                </div>

                <div class="col-span-1 mt-10 w-full gap-2">
                    <h1 class="text-3xl text-gray-800 font-semibold mb-10">Product Information</h1>
                    <input name="email" value="${user.email}" class="" placeholder="Email" hidden/>
                    <input name="productName" class="input mb-2 w-full flex" placeholder="Product Name"/>
                    <input name="category" class="input mb-2 w-full flex" placeholder="Category"/>
                    <input name="price" class="input mb-2 w-full flex" placeholder="Price"/>
                    <input name="quantity" class="input mb-2 w-full flex" placeholder="Quantity"/>
                    <textarea name="details" class="textarea p-4 rounded-lg bg-gray-800 w-full flex mb-2 h-24 resize-none" placeholder="Details"></textarea>
                    <div class="w-full flex justify-end">
                        <button type="submit" class="btn">Add product</button>
                    </div>
                </div>      
            </form>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
        const dropZone = document.getElementById('drop-zone');
        const fileUpload = document.getElementById('file-upload');
        const fileName = document.getElementById('file-name');
        const filePath = document.getElementById('file-path');
        const imagePreview = document.getElementById('image-preview');
        const previewImage = document.getElementById('preview-image');
        
        // Store the full path globally so it's accessible in form submission
        let fullFilePath = '';

        // Prevent default drag behaviors
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            dropZone.addEventListener(eventName, preventDefaults, false);
            document.body.addEventListener(eventName, preventDefaults, false);
        });

        // Highlight drop zone when item is dragged over it
        ['dragenter', 'dragover'].forEach(eventName => {
            dropZone.addEventListener(eventName, highlight, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            dropZone.addEventListener(eventName, unhighlight, false);
        });

        // Handle dropped files
        dropZone.addEventListener('drop', handleDrop, false);

        // Handle selected files
        fileUpload.addEventListener('change', handleFiles, false);

        dropZone.addEventListener('click', () => fileUpload.click());

        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }

        function highlight() {
            dropZone.classList.add('border-blue-500');
            dropZone.classList.add('bg-blue-100');
        }

        function unhighlight() {
            dropZone.classList.remove('border-blue-500');
            dropZone.classList.remove('bg-blue-100');
        }

        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;
            handleFiles({ target: { files } });
        }

        function handleFiles(e) {
            const files = e.target.files;
            if (files.length > 0) {
                const file = files[0];
                if (file.type.startsWith('image/')) {
                    uploadFile(file);
                } else {
                    alert('Please select an image file.');
                }
            }
        }

        function uploadFile(file) {
            if (fileName) fileName.textContent = file.name;
            
            // Store the full path
            fullFilePath = file.webkitRelativePath || file.name;
            if (filePath) filePath.value = fullFilePath;

            // Preview image
            if (previewImage && imagePreview) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImage.src = e.target.result;
                    imagePreview.classList.remove('hidden');
                }
                reader.readAsDataURL(file);
            }
        }

        const productForm = document.getElementById('productForm');
        if (productForm) {
            productForm.addEventListener('submit', async function(e) {
                e.preventDefault();
                const form = e.target;
                
                try {
                    const formData = {
                        productName: form.productName.value,
                        category: form.category.value,
                        price: form.price.value,
                        details: form.details.value,
                        email: form.email.value,
                        imageUrl: "C:/Users/Khent Harold/Downloads/asdf.png", // Using the stored full path
                        quantity: form.quantity.value
                    };
                    console.log(formData);
                    const response = await fetch('/products', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify(formData)
                    });

                    if (!response.ok) {
                        throw new Error('Failed to create product. Please try again.');
                    }

                    const data = await response.json();
                    console.log('Product created:', data);
                    
                    // Redirect to main page on success
                    window.location.href = '/main';

                } catch (error) {
                    console.error(error);
                    alert(error.message);
                }
            });
        } 
    });
        </script>
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