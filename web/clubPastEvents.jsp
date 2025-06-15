<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Past Events - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .event-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:25px;padding-bottom:20px}.event-card{background-color:#fff;border-radius:12px;box-shadow:0 4px 12px rgba(0,0,0,.1);overflow:hidden;display:flex;flex-direction:column;transition:transform .3s ease}.event-card:hover{transform:translateY(-5px)}.event-card img{width:100%;height:180px;object-fit:cover;border-bottom:1px solid #eee}.event-card-content{padding:15px;flex-grow:1}.event-card-content h3{font-size:20px;margin-top:0;margin-bottom:10px;color:#003366}.event-details{font-size:14px;color:#555;margin-bottom:8px}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Past Events" scope="request"/>
    <jsp:include page="/includes/clubSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="event-grid">
            <c:choose>
                <c:when test="${not empty pastEvents}"><c:forEach var="activity" items="${pastEvents}">
                    <div class="event-card">
                        <img src="${pageContext.request.contextPath}/${activity.image_path}" onerror="this.src='${pageContext.request.contextPath}/images/default_event_poster.png'">
                        <div class="event-card-content">
                            <h3>${activity.activity_name}</h3>
                            <p class="event-details"><strong>Date:</strong> <fmt:formatDate value="${activity.activity_enddate}" pattern="dd MMM, yyyy"/></p>
                            <p class="event-details"><strong>Status:</strong> ${activity.activity_status}</p>
                        </div>
                    </div>
                </c:forEach></c:when>
                <c:otherwise><p>No past events found for this club.</p></c:otherwise>
            </c:choose>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>