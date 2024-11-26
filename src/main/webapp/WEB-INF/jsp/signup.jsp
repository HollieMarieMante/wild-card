<!DOCTYPE html>
<html>
<head>
    <link href=" /css/styles.css" ref="stylesheet">
    <script src="httsp://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=poppins:wght@300;400;500;700&display=swap" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Signup - WildCart</title>
    <style>
        body {
            font-family: 'poppins', sans-serif;
        }
        .gradient-background {
            background: linear-gradient(to right, #F2E8C6, #800000);
            width: 100dvw;
            height: 100dvh;
            display: grid;
            grid-template-columns: 1fr 1fr;
            align-items: center;
            padding: 0 3.5rem;
            position: fixed;
            top: 0;
            left: 0;    
        }

        .logo-container {
            display: flex;
            justify-content: center;
            align-items: center;
            column-span: 1;
            width: 100%;
            height: 100%;
        }

        .logo {
            width: 400px;
            height: 200px;
        }

        .form-container {
            column-span: 1;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            height: 100%;
            padding-left: 2rem;
        }

        .login-form {
            width: 70%;
            background-color: rgba(242, 232, 198, 0.5);
            padding: 2.5rem;
            border-radius: 1.5rem;
            border: 2px solid rgba(0, 0, 0, 0.1);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 1rem;
        }

        .span-2 {
            grid-column: span 2;
        }

        .input-container {
            width: 90%;
            margin: 0 auto 0.75rem auto;
        }

        .form-input {
            width: 100%;
            height: 30px;
            padding: .5rem;
            border-radius: 0.375rem;
            border: 1px solid rgba(0, 0, 0, 0.2);
            margin-bottom: 0.75rem;
        }

        .form-button {
            width: 80%;
            padding: 1rem;
            background-color: #2563eb;
            color: white;
            border: none;
            border-radius: 0.375rem;
            cursor: pointer;
            margin: 1.25rem 0;
        }

        .form-button:disabled {
            background-color: #93c5fd;
            cursor: not-allowed;
        }

        .separator {
            width: 80%;
            height: 1px;
            background-color: currentColor;
            margin: 1.25rem auto;
        }

        .error-message {
            color: #ef4444;
            font-size: 0.875rem;
            margin-bottom: 0.75rem;
            text-align: center;
        }

        .signup-link {
            text-align: center;
        }

        .signup-link a {
            color: #1e40af;
            text-decoration: none;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>    
</head>
<body>
    <div class="gradient-background">
        <div class="logo-container">
            <img src='/assets/wildcart-logos.png' alt="Logo" class="w-32 h-32 transition-all duration-700 delay-100 animate-float-in opacity-0">
        </div>
        
        <div class="form-container">
            <div class="login-form transition-all duration-700 animate-float-in opacity-0">
                <h1 style="font-weight: bold; font-size: 1.25rem; margin-bottom: 1.25rem delay-300 transition-all duration-700 animate-float-in opacity-0;">Signup</h1>
                
                <form id="signupform">
                    <div class="form-grid">
                        <div class="span-2">
                            <input type="text" 
                                   name="name" 
                                   placeholder="Fullname"
                                   class="form-input transition-all delay-400 duration-700 animate-float-in opacity-0" 
                                   required>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div>
                            <input type="password" 
                                   name="password" 
                                   placeholder="Password" 
                                   class="form-input transition-all duration-700 animate-float-in opacity-0" 
                                   required>
                        </div>
                        <div>
                            <input type="password" 
                                   name="confirmPassword" 
                                   placeholder="Confirm Password" 
                                   class="form-input transition-all duration-700 animate-float-in opacity-0" 
                                   required>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div>
                            <input type="text" 
                                   name="studentId" 
                                   placeholder="Student ID No." 
                                   class="form-input transition-all duration-700 animate-float-in opacity-0" 
                                   required>
                        </div>
                        <div>
                            <input type="text" 
                                   name="course" 
                                   placeholder="Course" 
                                   class="form-input transition-all duration-700 animate-float-in opacity-0"  
                                   required>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div>
                            <input type="email" 
                                   name="email" 
                                   placeholder="Email" 
                                   class="form-input transition-all duration-700 animate-float-in opacity-0" 
                                   required>
                        </div>
                        <div>
                            <input type="text" 
                                   name="mobileNumber" 
                                   placeholder="Mobile Number" 
                                   class="form-input transition-all duration-700 animate-float-in opacity-0" 
                                   required>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="span-2">
                            <input type="text" 
                                   name="address" 
                                   placeholder="Address" 
                                   class="form-input transition-all duration-700 animate-float-in opacity-0" 
                                   required>
                        </div>
                    </div>
                    
                    <c:if test="${not empty errorMessage}">
                        <p class="error-message">${errorMessage}</p>
                    </c:if>

                    <div style="display: flex; flex-direction: column; align-items: center;">
                        <button type="submit" class="form-button transition-all duration-700 animate-float-in opacity-0">
                            Sign Up
                        </button>
                        
                        <div class="separator transition-all duration-700 animate-float-in opacity-0"></div>
                        
                        <div class="signup-link transition-all duration-700 animate-float-in opacity-0">
                            <p>Already have an account? <a href="/login">Login here</a>.</p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('signupform').addEventListener('submit', async function(e) {
            e.preventDefault();
            const form = e.target;
            const email = form.email.value;
            const submitButton = form.querySelector('button[type="submit"]');
            const errorDiv = form.querySelector('.error-message') || document.createElement('p');
            errorDiv.className = 'error-message';

            // Basic validation
            if (form.password.value !== form.confirmPassword.value) {
                errorDiv.textContent = 'Passwords do not match';
                if (!document.querySelector('.error-message')) {
                    form.querySelector('.form-grid').appendChild(errorDiv);
                }
                return;
            }

            try {
                submitButton.disabled = true;
                submitButton.textContent = 'Signing up...';

                const userData = {
                    name: form.name.value,
                    email: form.email.value,
                    password: form.password.value,
                    studentId: form.studentId.value,
                    course: form.course.value,
                    mobileNumber: form.mobileNumber.value,
                    address: form.address.value
                };

                const signupResponse = await fetch('/users', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(userData)
                });

                if (!signupResponse.ok) {
                    throw new Error('Signup failed. Please try again.');
                }

                const newUser = await signupResponse.json();

                // Create sanitized version for session
                const sanitizedUserData = {
                    userId: newUser.userId,
                    name: newUser.name,
                    email: newUser.email,
                    studentId: newUser.studentId,
                    course: newUser.course
                };

                // Set session cookie
                document.cookie = `session=${JSON.stringify(sanitizedUserData)}; path=/; secure; samesite=strict; max-age=86400`;
                
                // Redirect to main page
                window.location.href = '/main';

            } catch (error) {
                errorDiv.textContent = error.message;
                if (!document.querySelector('.error-message')) {
                    form.querySelector('.form-grid').appendChild(errorDiv);
                }
            } finally {
                submitButton.disabled = false;
                submitButton.textContent = 'Sign Up';
            }
        });

        // Add password confirmation validation
        const passwordInput = document.querySelector('input[name="password"]');
        const confirmPasswordInput = document.querySelector('input[name="confirmPassword"]');
        const errorDiv = document.createElement('p');
        errorDiv.className = 'error-message';

        confirmPasswordInput.addEventListener('input', function() {
            if (this.value !== passwordInput.value) {
                errorDiv.textContent = 'Passwords do not match';
                if (!document.querySelector('.error-message')) {
                    this.parentNode.appendChild(errorDiv);
                }
            } else {
                errorDiv.remove();
            }
        });
    </script>
</body>
</html>