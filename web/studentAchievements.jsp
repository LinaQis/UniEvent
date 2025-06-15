<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Achievements - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .achievements-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:25px;padding-bottom:20px}.achievement-card{background-color:#fff;border-radius:12px;box-shadow:0 4px 12px rgba(0,0,0,.1);overflow:hidden;display:flex;flex-direction:column;align-items:center;text-align:center;padding:20px;transition:transform .3s ease}.achievement-card:hover{transform:translateY(-5px)}.achievement-icon{font-size:40px;color:#ffd93d;margin-bottom:15px}.achievement-card h3{font-size:20px;margin-top:0;margin-bottom:10px;color:#003366}.achievement-details{font-size:14px;color:#666;line-height:1.5;margin-bottom:15px}.certificate-link{background-color:#4285f4;color:#fff;padding:10px 20px;border:none;border-radius:8px;font-weight:600;text-decoration:none;display:inline-block}.no-certificate{font-size:14px;color:#999;padding:10px 20px;display:inline-block}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Achievements" scope="request"/>
    <jsp:include page="/includes/studentSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="achievements-grid">
            <c:choose>
                <c:when test="${not empty achievements}"><c:forEach var="achievement" items="${achievements}">
                    <div class="achievement-card">
                        <span class="achievement-icon">🏆</span>
                        <h3>${achievement.title}</h3>
                        <p class="achievement-details">
                            Awarded for: ${achievement.description}<br>
                            On: <fmt:formatDate value="${achievement.date_awarded}" pattern="dd MMMM, yyyy"/>
                        </p>
                        <c:if test="${not empty achievement.cert_path}">
                            <a href="${pageContext.request.contextPath}${achievement.cert_path}" target="_blank" class="certificate-link">View Certificate</a>
                        </c:if>
                        <c:if test="${empty achievement.cert_path}">
                            <span class="no-certificate">No certificate available</span>
                        </c:if>
                    </div>
                </c:forEach></c:when>
                <c:otherwise><p>You haven't earned any achievements yet.</p></c:otherwise>
            </c:choose>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>