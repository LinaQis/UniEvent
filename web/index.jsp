<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>UniEvent Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>
<body class="home-page">
    <header>
        <nav>
            <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
            <a href="${pageContext.request.contextPath}/signup.jsp">Sign Up</a>
        </nav>
    </header>
    <section class="logo-container">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="UniEvent Logo" class="left-logo">
        <img src="${pageContext.request.contextPath}/images/uitm.png" alt="UiTM Logo" class="left-logo">
    </section>
    <main class="hero-banner">
        <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="Banner" class="banner-image">
        <div class="hero-text">
            <h1>WELCOME<br>TO<br><span>UniEvent</span></h1>
        </div>
    </main>
</body>
</html>