<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Activities - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        /* [NEW] Styles to beautify the table */
        .table-container {
            background-color: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            overflow-x: auto;
        }

        .activity-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
            font-size: 15px;
        }

        .activity-table th, .activity-table td {
            text-align: left;
            padding: 16px;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: middle;
        }

        .activity-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
            text-transform: uppercase;
            font-size: 12px;
        }

        .activity-table tbody tr:hover {
            background-color: #f1f7ff;
        }

        .activity-table td {
            color: #5a6a7e;
        }
        
        .activity-table td strong {
            font-weight: 600;
            color: #333;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            color: #fff;
        }
        .status-approved { background-color: #28a745; }
        .status-pending { background-color: #ffc107; color: #333; }
        .status-rejected, .status-cancelled { background-color: #dc3545; }
        .status-completed { background-color: #6c757d; }
        .status-in-progress { background-color: #17a2b8; }

        .view-details-btn {
            background-color: #007bff;
            color: white;
            padding: 8px 18px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.2s ease, box-shadow 0.2s ease;
        }

        .view-details-btn:hover {
            background-color: #0056b3;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Activities" scope="request"/>
    <jsp:include page="/includes/staffSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />

        <c:if test="${param.update == 'success'}">
            <div class="status-message success-message" style="margin-bottom: 20px;">
                Activity status has been updated successfully.
            </div>
        </c:if>

        <div class="table-container">
            <table class="activity-table">
                <thead>
                    <tr>
                        <th>Activity Name</th>
                        <th>Club</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty activities}">
                            <c:forEach var="activity" items="${activities}">
                                <tr>
                                    <td><strong>${activity.activity_name}</strong></td>
                                    <td>${activity.club_name}</td>
                                    <td><fmt:formatDate value="${activity.activity_startdate}" pattern="dd MMM, yyyy"/></td>
                                    <td>
                                        <span class="status-badge status-${fn:toLowerCase(activity.activity_status)}">
                                            ${activity.activity_status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/staff/activityDetails?activity_id=${activity.activity_id}" class="view-details-btn">View Details</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 40px;">No activities have been submitted yet.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>
