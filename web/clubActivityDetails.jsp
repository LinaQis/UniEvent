<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Activity Details - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .details-container { background-color: #fff; padding: 30px; border-radius: 15px; box-shadow: 0 4px 12px rgba(0,0,0,.1); }
        .details-group { margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px dashed #eee; }
        .details-group:last-child { border-bottom: none; }
        .details-group h4 { font-size: 18px; color: #003366; margin-bottom: 10px; }
        .details-group p { font-size: 15px; line-height: 1.6; color: #555; margin-bottom: 8px; }
        .details-group strong { color: #333; }
        .document-link { display: inline-block; background-color: #4285f4; color: #fff; padding: 8px 15px; border-radius: 6px; text-decoration: none; font-size: 14px; font-weight: 500; margin-right: 10px; }
        .committee-list { list-style: none; padding: 0; }
        .committee-list li { background-color: #f8f9fa; padding: 10px 15px; border-radius: 8px; margin-bottom: 8px; }
        .action-buttons { display: flex; justify-content: flex-end; gap: 15px; margin-top: 30px; }
        .action-buttons button, .action-buttons a { padding: 12px 25px; border: none; border-radius: 8px; font-weight: 700; cursor: pointer; font-size: 16px; text-decoration: none; text-align: center;}
        .edit-btn { background-color: #ffc107; color: #212529; }
        .return-btn { background-color: #6c757d; color: #fff; }
        .status-badge { display: inline-block; padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase; color: #fff; }
        .status-badge.pending { background-color: #ffc107; color: #212529; }
        .status-badge.approved { background-color: #28a745; }
        .status-badge.rejected { background-color: #dc3545; }
        .status-badge.completed { background-color: #6c757d; }
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Activity Details" scope="request"/>
    <jsp:include page="/includes/clubSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="details-container">
            <c:if test="${not empty activity}">
                <div class="details-group">
                    <h4>Basic Information</h4>
                    <p><strong>Activity Name:</strong> ${activity.activity_name}</p>
                    <p><strong>Status:</strong> <span class="status-badge status-${fn:toLowerCase(activity.activity_status)}">${activity.activity_status}</span></p>
                </div>

                <div class="details-group">
                    <h4>Event Details</h4>
                    <p><strong>Description:</strong> <c:out value="${activity.activity_desc}"/></p>
                </div>

                <div class="details-group">
                    <h4>Logistics</h4>
                    <p><strong>Date & Time:</strong> <fmt:formatDate value="${activity.activity_startdate}" pattern="dd MMM, yyyy, hh:mm a"/> to <fmt:formatDate value="${activity.activity_enddate}" pattern="hh:mm a"/></p>
                    <p><strong>Location:</strong> ${activity.activity_location}</p>
                </div>

                <div class="details-group">
                    <h4>Budget & Documents</h4>
                    <p><strong>Total Budget:</strong> RM <fmt:formatNumber value="${activity.total_budget}" pattern="#,##0.00"/></p>
                    <p>
                        <a href="${pageContext.request.contextPath}/${activity.program_flow_path}" target="_blank" class="document-link">Program Flow</a>
                        <a href="${pageContext.request.contextPath}/${activity.budget_path}" target="_blank" class="document-link">Budget</a>
                        <a href="${pageContext.request.contextPath}/${activity.image_path}" target="_blank" class="document-link">Poster</a>
                    </p>
                </div>
            </c:if>

            <div class="action-buttons" style="justify-content: flex-start; margin-top:20px;">
                 <a href="${pageContext.request.contextPath}/club/activities" class="return-btn">Back to List</a>
                 <%-- You can add an "Edit" button here that links to an edit page if you create one --%>
                 <%-- <a href="#" class="edit-btn">Edit Details</a> --%>
            </div>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>
