<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>My Activities - UniEvent</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .activity-table-container{overflow-x:auto;width:100%}.activity-table{width:100%;border-collapse:collapse;margin-top:20px;background-color:#fff;border-radius:8px;overflow:hidden;box-shadow:0 4px 8px rgba(0,0,0,.05)}.activity-table th,.activity-table td{padding:12px 15px;text-align:left;border-bottom:1px solid #ddd}.activity-table th{background-color:#f2f2f2;font-weight:600;color:#333;text-transform:uppercase;font-size:.9em}.activity-table tr:hover{background-color:#f9f9f9}.activity-table td img.activity-poster{width:80px;height:50px;object-fit:cover;border-radius:4px}.status-badge{padding:5px 10px;border-radius:20px;font-size:.8em;font-weight:600;color:#fff;text-align:center;display:inline-block}.status-badge.pending{background-color:#ffc107}.status-badge.approved{background-color:#28a745}.status-badge.rejected{background-color:#dc3545}.status-badge.completed{background-color:#6c757d}.status-badge.in-progress{background-color:#007bff}.action-btns a{background-color:#6b46f2;color:#fff;padding:8px 12px;border:none;border-radius:5px;cursor:pointer;font-size:.9em;transition:background-color .2s ease;text-decoration:none;display:inline-block;text-align:center}.action-btns a:hover{background-color:#5a39d9}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="My Activities" scope="request"/>
    <jsp:include page="/includes/clubSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="content-header">
            <h1>Activity List for <c:out value="${sessionScope.clubName}"/></h1>
            <a href="${pageContext.request.contextPath}/club/activityProposal" class="btn-primary" style="background-color: #0056b3; color: white; padding: 10px 15px; border-radius: 5px; text-decoration: none;">Propose New Activity</a>
        </div>
        <div class="activity-table-container">
            <table class="activity-table">
                <thead>
                    <tr>
                        <th>Poster</th><th>Name</th><th>Category</th><th>Location</th><th>Start Date</th><th>End Date</th><th>Status</th><th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty activities}"><c:forEach var="activity" items="${activities}">
                            <tr>
                                <td><img src="${pageContext.request.contextPath}/${activity.image_path}" alt="Poster" class="activity-poster" onerror="this.onerror=null;this.src='https://placehold.co/80x50/cccccc/333333?text=No+Image';"></td>
                                <td><c:out value="${activity.activity_name}"/></td>
                                <td><c:out value="${activity.category_name}"/></td>
                                <td><c:out value="${activity.activity_location}"/></td>
                                <td><fmt:formatDate value="${activity.activity_startdate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td><fmt:formatDate value="${activity.activity_enddate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td><span class="status-badge ${activity.activity_status.toLowerCase().replace(' ', '-')}"><c:out value="${activity.activity_status}"/></span></td>
                                <td class="action-btns"><a href="${pageContext.request.contextPath}/club/activityDetails?activity_id=${activity.activity_id}">Details</a></td>
                            </tr>
                        </c:forEach></c:when>
                        <c:otherwise><tr><td colspan="8" style="text-align:center;padding:20px;">No activities found for this club.</td></tr></c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>