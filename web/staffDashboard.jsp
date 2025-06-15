<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    
    <!-- [FIX] Changed the href to use the absolute context path -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    
    <style>
        .dashboard-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:20px;margin-bottom:30px}.dashboard-card{background-color:#fff;padding:25px;border-radius:12px;box-shadow:0 4px 10px rgba(0,0,0,.08);text-align:center}.dashboard-card h3{font-size:1.2em;color:#555;margin-bottom:10px}.dashboard-card .count{font-size:2.5em;font-weight:700;color:#4285f4}.dashboard-section{background-color:#fff;padding:25px;border-radius:12px;box-shadow:0 4px 10px rgba(0,0,0,.08)}.dashboard-section h4{font-size:1.5em;color:#333;margin-bottom:20px;font-weight:600;border-bottom:2px solid #eee;padding-bottom:10px}.item-list{list-style:none;padding:0}.item-list li{display:flex;align-items:center;justify-content:space-between;padding:12px 0;border-bottom:1px solid #eee}.item-list li:last-child{border-bottom:none}.item-title{font-weight:600;color:#333}.item-status{display:inline-block;padding:5px 10px;border-radius:20px;font-size:.8em;font-weight:600;color:#000;background-color:#ffd93d}.view-details-btn{background-color:#0f60b6;color:#fff;padding:8px 15px;border-radius:6px;text-decoration:none}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Staff Dashboard" scope="request"/>
    <jsp:include page="/includes/staffSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="dashboard-grid">
            <div class="dashboard-card">
                <h3>Total Activities</h3>
                <div class="count">${totalActivities}</div>
                <p>All events in the system.</p>
            </div>
            <div class="dashboard-card">
                <h3>Total Students</h3>
                <div class="count">${totalStudents}</div>
                <p>Active students in the system.</p>
            </div>
            <div class="dashboard-card">
                <h3>Total Clubs</h3>
                <div class="count">${totalClubs}</div>
                <p>Registered clubs.</p>
            </div>
        </div>

        <div class="dashboard-section">
            <h4>Pending Activity Proposals</h4>
            <ul class="item-list">
                <c:choose>
                    <c:when test="${not empty pendingActivities}"><c:forEach var="activity" items="${pendingActivities}">
                        <li>
                            <span class="item-title">${activity.activity_name} by ${activity.club_name}</span>
                            <span class="item-status">PENDING</span>
                            <a href="${pageContext.request.contextPath}/staff/activityDetails?activity_id=${activity.activity_id}" class="view-details-btn">View Details</a>
                        </li>
                    </c:forEach></c:when>
                    <c:otherwise><li>No pending activity proposals.</li></c:otherwise>
                </c:choose>
            </ul>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>
