<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="upcomingEvents" scope="request" type="java.util.List<model.Activity>"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Upcoming Events</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <jsp:include page="studentSidebar.jsp" />
    <div class="topbar-container">
        <div class="sub-header">
            <div>Upcoming Events</div>
            <div>Home &gt; Events &gt; <strong>Upcoming Events</strong></div>
        </div>
    </div>
    <div class="main-content">
        <h2 style="color: white;">All Upcoming Events</h2>
        <div class="event-list">
            <c:forEach var="event" items="${upcomingEvents}">
                <a href="studentEventDetails?activityId=${event.activity_id}" class="event-card-link">
                    <div class="event-card">
                        <img src="${event.image_path}" alt="${event.activity_name}">
                        <div class="event-card-content">
                            <div class="event-date">
                                <fmt:formatDate value="${event.activity_startdate}" pattern="MMM" var="month"/>
                                <fmt:formatDate value="${event.activity_startdate}" pattern="dd" var="day"/>
                                <div style="font-size: 14px;">${month}</div>
                                <div style="font-size: 20px; font-weight: bold;">${day}</div>
                            </div>
                            <div>
                                <div class="event-title">${event.activity_name}</div>
                                <div class="event-meta"><fmt:formatDate value="${event.activity_startdate}" pattern="E hh:mm a"/> &middot; ${event.activity_location}</div>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
            <c:if test="${empty upcomingEvents}">
                <p style="color:white;">No upcoming events at the moment. Check back later!</p>
            </c:if>
        </div>
    </div>
    <jsp:include page="studentFooter.jsp" />
</body>
</html>