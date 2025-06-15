<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Activity History - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .activity-history-table{width:100%;border-collapse:collapse;min-width:700px}.activity-history-table th,.activity-history-table td{text-align:left;padding:12px 15px;border-bottom:1px solid #eee;font-size:14px}.activity-history-table th{background-color:#f8f9fa;font-weight:600;color:#555;text-transform:uppercase}.activity-history-table tbody tr:hover{background-color:#f0f8ff}.status-badge{display:inline-block;padding:5px 10px;border-radius:20px;font-size:12px;font-weight:600;text-transform:uppercase;color:#fff}.status-completed{background-color:#4caf50}.status-in-progress{background-color:#ffd93d;color:#000}.status-upcoming{background-color:#4285f4}.status-cancelled{background-color:#f14c4c}.view-details-btn{background-color:#0f60b6;color:#fff;padding:8px 15px;border:none;border-radius:6px;text-decoration:none;font-size:13px}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Activity History" scope="request"/>
    <jsp:include page="/includes/studentSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="table-container" style="background-color: white; padding: 20px; border-radius: 8px;">
            <table class="activity-history-table">
                <thead>
                    <tr><th>No.</th><th>Activity Name</th><th>Club Name</th><th>Date</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty registeredActivities}"><c:forEach var="activity" items="${registeredActivities}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${activity.activity_name}</td>
                                <td>${activity.club_name}</td>
                                <td><fmt:formatDate value="${activity.activity_startdate}" pattern="dd MMM, yyyy"/></td>
                                <td><span class="status-badge status-${activity.activity_status.toLowerCase().replace(' ', '-')}">${activity.activity_status}</span></td>
                                <td><a href="${pageContext.request.contextPath}/student/eventDetails?activity_id=${activity.activity_id}" class="view-details-btn">View Details</a></td>
                            </tr>
                        </c:forEach></c:when>
                        <c:otherwise><tr><td colspan="6">You have not registered for any activities yet.</td></tr></c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>