<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Events - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .event-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:25px;padding-bottom:20px}.event-card{background-color:#fff;border-radius:12px;box-shadow:0 4px 12px rgba(0,0,0,.1);overflow:hidden;display:flex;flex-direction:column;transition:transform .3s ease}.event-card:hover{transform:translateY(-5px);box-shadow:0 6px 15px rgba(0,0,0,.15)}.event-card img{width:100%;height:180px;object-fit:cover;border-bottom:1px solid #eee}.event-card-content{padding:15px;flex-grow:1;display:flex;flex-direction:column}.event-card-content h3{font-size:20px;margin-top:0;margin-bottom:10px;color:#003366}.event-details{font-size:14px;color:#555;margin-bottom:8px}.event-details strong{color:#333}.event-description{font-size:14px;color:#666;line-height:1.5;margin-bottom:15px;flex-grow:1;overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical}.register-btn{background-color:#32d183;color:#fff;padding:10px 20px;border:none;border-radius:8px;font-weight:600;text-decoration:none;display:block;margin-top:auto;transition:background-color .2s ease;text-align:center}.register-btn:hover{background-color:#2ab870}.register-btn[disabled]{background-color:#a0a0a0;cursor:not-allowed}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Events" scope="request"/>
    <jsp:include page="/includes/studentSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="event-grid">
            <c:choose>
                <c:when test="${not empty availableActivities}"><c:forEach var="activity" items="${availableActivities}">
                    <div class="event-card">
                        <img src="${pageContext.request.contextPath}/${activity.image_path}" onerror="this.src='${pageContext.request.contextPath}/images/default_event_poster.png'">
                        <div class="event-card-content">
                            <h3>${activity.activity_name}</h3>
                            <p class="event-details"><strong>Club:</strong> ${activity.club_name}</p>
                            <p class="event-details"><strong>Date:</strong> <fmt:formatDate value="${activity.activity_startdate}" pattern="dd MMM, yyyy"/></p>
                            <p class="event-description">${activity.activity_desc}</p>
                            <c:choose>
                                <c:when test="${activity.registered}">
                                    <button class="register-btn" disabled>Registered</button>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/EventRegistrationServlet" method="post" style="margin-top:auto;">
                                        <input type="hidden" name="action" value="register">
                                        <input type="hidden" name="activity_id" value="${activity.activity_id}">
                                        <button type="submit" class="register-btn">Register Now</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach></c:when>
                <c:otherwise><p>No events available for registration.</p></c:otherwise>
            </c:choose>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>