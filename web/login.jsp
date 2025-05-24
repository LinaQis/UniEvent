<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - UniEvent</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body class="form-page">
    <header>
        <nav>
            <a href="index.jsp">Home</a>
            <a href="login.jsp">Login</a>
            <a href="signup.jsp">Sign Up</a>
        </nav>
    </header>
    <div class="main-content">
        <div class="left-panel">
            <div class="logo-container">
                <img src="images/logo.png" alt="UniEvent Logo" class="form-logo">
            </div>
            <h2 class="form-title">Welcome back!</h2>
            <p class="form-subtitle">Enter your credentials to access your account</p>

            <!-- Display error messages -->
            <% 
                String error = request.getParameter("error"); 
                if ("wrongpass".equals(error)) {
            %>
                <p style="color:red;">Incorrect password. Please try again.</p>
            <% } else if ("nouser".equals(error)) { %>
                <p style="color:red;">Account not found. Please check your ID or email.</p>
            <% } %>

            <form action="LoginServlet" method="post">
                <div class="radio-group">
                    <label><input type="radio" name="role" value="Student" checked> Student</label>
                    <label><input type="radio" name="role" value="Club Organizer"> Club Organizer</label>
                    <label><input type="radio" name="role" value="Admin/Staff"> Admin/Staff</label>
                </div>

                <label>Username</label>
                <input type="text" id="username" name="username" placeholder="Enter your student no" required>

                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>

                <div class="options">
                    <label><input type="checkbox" name="remember"> Remember me for 30 days</label>
                    <a href="#">Forgot password?</a>
                </div>

                <button type="submit" class="blue-button">Login</button>
            </form>

            <p class="signup-text">Don’t have an account? <a href="signup.jsp">Sign Up</a></p>
        </div>
        <div class="right-panel"></div>
    </div>

    <script>
        const roleRadios = document.querySelectorAll('input[name="role"]');
        const usernameInput = document.getElementById('username');

        function updatePlaceholder() {
            const selectedRole = document.querySelector('input[name="role"]:checked').value;

            if (selectedRole === "Student") {
                usernameInput.placeholder = "Enter your student ID";
            } else if (selectedRole === "Club Organizer") {
                usernameInput.placeholder = "Enter your club email";
            } else if (selectedRole === "Admin/Staff") {
                usernameInput.placeholder = "Enter your staff ID";
            }
        }

        updatePlaceholder();
        roleRadios.forEach(radio => {
            radio.addEventListener('change', updatePlaceholder);
        });
    </script>
</body>
</html>