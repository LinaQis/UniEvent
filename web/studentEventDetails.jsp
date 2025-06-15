<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Event Details - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .event-details-container{display:flex;flex-wrap:wrap;justify-content:center;gap:40px;align-items:flex-start;background:#d7e6f3;padding:40px;border-radius:16px}.event-poster{max-width:300px;border-radius:10px;box-shadow:0 4px 12px rgba(0,0,0,.1)}.event-info{max-width:500px;font-size:15px;line-height:1.6}.event-info h2{color:#333}.event-info-box{background:#fff;padding:16px;border-radius:12px;box-shadow:0 2px 8px rgba(0,0,0,.1);margin-bottom:20px}.event-info-box p{margin:5px 0}.register-btn{display:inline-block;margin-top:24px;background:#4f5bd5;color:#fff;padding:12px 24px;border-radius:30px;font-weight:600;text-decoration:none;box-shadow:0 3px 8px rgba(0,0,0,.2)}.register-btn[disabled]{background-color:#a0a0a0;cursor:not-allowed}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Event Details" scope="request"/>
    <jsp:include page="/includes/studentSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="event-details-container">
            <c:choose>
                <c:when test="${not empty activity}">
                    <img src="${pageContext.request.contextPath}/${activity.image_path}" alt="Event Poster" class="event-poster" onerror="this.src='${pageContext.request.contextPath}/images/default_event_poster.png'">
                    <div class="event-info">
                        <h2><c:out value="${activity.activity_name}"/></h2>
                        <div class="event-info-box">
                            <p><strong>Location:</strong> <c:out value="${activity.activity_location}"/></p>
                            <p><strong>Date:</strong> <fmt:formatDate value="${activity.activity_startdate}" pattern="dd MMM, yyyy"/></p>
                            <p><strong>Time:</strong> <fmt:formatDate value="${activity.activity_startdate}" pattern="hh:mm a"/> - <fmt:formatDate value="${activity.activity_enddate}" pattern="hh:mm a"/></p>
                        </div>
                        <p><c:out value="${activity.activity_desc}"/></p>
                        
                        <c:if test="${not activity.completed}">
                            <c:choose>
                                <c:when test="${activity.registered}">
                                    <button class="register-btn" disabled>Already Registered</button>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/EventRegistrationServlet" method="post" style="margin-top:auto;">
                                        <input type="hidden" name="action" value="register">
                                        <input type="hidden" name="activity_id" value="${activity.activity_id}">
                                        <button type="submit" class="register-btn">Register Now</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise><p>Event details not found.</p></c:otherwise>
            </c:choose>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>