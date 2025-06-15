<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - UniEvent</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .status-message { padding: 15px; margin-bottom: 20px; border-radius: 8px; font-size: 14px; font-weight: 500; text-align: center; }
        .success-message { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error-message { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
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
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="UniEvent Logo" class="form-logo">
            </div>
            <h2 class="form-title">Welcome back!</h2>
            <p class="form-subtitle">Enter your credentials to access your account</p>

            <%-- Display messages from servlets --%>
            <c:if test="${not empty param.registration}">
                <c:choose>
                    <c:when test="${param.registration == 'success_auto_approved'}">
                        <div class="status-message success-message">Registration successful! You can now log in.</div>
                    </c:when>
                    <c:when test="${param.registration == 'duplicateId'}">
                         <div class="status-message error-message">Registration failed. The ID you entered already exists.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="status-message error-message">An error occurred during registration. Please try again.</div>
                    </c:otherwise>
                </c:choose>
            </c:if>

             <c:if test="${not empty param.error}">
                <div class="status-message error-message">
                     <c:choose>
                        <c:when test="${param.error == 'wrongCredentials'}">Incorrect username or password.</c:when>
                        <c:when test="${param.error == 'notOrganizer'}">You are not registered as a Club Organizer for any club.</c:when>
                        <c:otherwise>An unexpected error occurred. Please try again.</c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <form action="LoginServlet" method="post">
                <div class="radio-group">
                    <label><input type="radio" name="role" value="Student" checked onchange="updatePlaceholder()"> Student</label>
                    <label><input type="radio" name="role" value="Club Organizer" onchange="updatePlaceholder()"> Club Organizer</label>
                    <label><input type="radio" name="role" value="Admin/Staff" onchange="updatePlaceholder()"> Admin/Staff</label>
                </div>
                <div class="form-group">
                    <label for="username">Username (ID)</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="options">
                    <label><input type="checkbox" name="remember"> Remember me</label>
                    <a href="#">Forgot password?</a>
                </div>
                <button type="submit" class="blue-button">Login</button>
            </form>
            <p class="signup-text">Don’t have an account? <a href="signup.jsp">Sign Up</a></p>
        </div>
        <div class="right-panel"></div>
    </div>
    <script>
        function updatePlaceholder() {
            const role = document.querySelector('input[name="role"]:checked').value;
            const usernameInput = document.getElementById('username');
            if (role === "Student" || role === "Club Organizer") {
                usernameInput.placeholder = "Enter your student ID";
            } else if (role === "Admin/Staff") {
                usernameInput.placeholder = "Enter your staff ID";
            }
        }
        document.addEventListener('DOMContentLoaded', updatePlaceholder);
    </script>
</body>
</html>
