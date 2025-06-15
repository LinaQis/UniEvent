<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Activity Reports - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .table-container {
            background-color: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            overflow-x: auto;
        }
        .reports-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
            font-size: 15px;
        }
        .reports-table th, .reports-table td {
            text-align: left;
            padding: 16px;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: middle;
        }
        .reports-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
            text-transform: uppercase;
            font-size: 12px;
        }
        .reports-table tbody tr:hover {
            background-color: #f1f7ff;
        }
        .reports-table td {
            color: #5a6a7e;
        }
        .reports-table td strong {
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
        .status-completed { background-color: #28a745; }
        .view-report-btn {
            background-color: #007bff;
            color: white;
            padding: 8px 18px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.2s ease;
        }
        .view-report-btn:hover {
            background-color: #0056b3;
        }
        .not-submitted {
            color: #888;
            font-style: italic;
        }
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Reports" scope="request"/>
    <jsp:include page="/includes/staffSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />

        <div class="table-container">
            <table class="reports-table">
                <thead>
                    <tr>
                        <th>Activity</th>
                        <th>Club</th>
                        <th>Completion Date</th>
                        <th>Status</th>
                        <th>Report</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty reports}">
                            <c:forEach var="activity" items="${reports}">
                                <tr>
                                    <td><strong>${activity.activity_name}</strong></td>
                                    <td>${activity.club_name}</td>
                                    <td><fmt:formatDate value="${activity.activity_enddate}" pattern="dd MMM, yyyy"/></td>
                                    <td><span class="status-badge status-completed">Completed</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty activity.report_path}">
                                                <a href="${pageContext.request.contextPath}/${activity.report_path}" class="view-report-btn" target="_blank">View Report</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="not-submitted">Not Submitted</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 40px;">No completed activity reports found.</td>
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
