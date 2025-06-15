<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Merit - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .merit-summary-card{background-color:#fff;padding:30px;border-radius:15px;box-shadow:0 4px 12px rgba(0,0,0,.1);text-align:center;margin-bottom:30px}.merit-summary-card h3{font-size:24px;color:#003366;margin-bottom:15px}.merit-score{font-size:60px;font-weight:700;color:#4caf50;margin-bottom:10px}.merit-history-section{background-color:#fff;padding:30px;border-radius:15px;box-shadow:0 4px 12px rgba(0,0,0,.1)}.merit-history-section h4{font-size:22px;color:#003366;margin-bottom:20px;text-align:center}.merit-table{width:100%;border-collapse:collapse}.merit-table th,.merit-table td{text-align:left;padding:12px 15px;border-bottom:1px solid #eee;font-size:15px}.merit-table th{background-color:#f8f9fa;font-weight:600;color:#555;text-transform:uppercase}.merit-table tbody tr:hover{background-color:#f0f8ff}.merit-value{font-weight:600;color:#4caf50}.merit-value.negative{color:#f14c4c}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Merit" scope="request"/>
    <jsp:include page="/includes/studentSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="merit-summary-card">
            <h3>Your Total Merit Score</h3>
            <div class="merit-score">${totalMerit}</div>
            <p>Merit points are awarded for participation in university activities.</p>
        </div>

        <div class="merit-history-section">
            <h4>Merit History</h4>
            <div class="merit-table-container">
                <table class="merit-table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Activity/Reason</th>
                            <th>Points</th>
                            <th>Remarks</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty meritHistory}"><c:forEach var="entry" items="${meritHistory}">
                                <tr>
                                    <td><fmt:formatDate value="${entry.merit_date}" pattern="dd MMM, yyyy"/></td>
                                    <td>${entry.activity_name}</td>
                                    <td class="merit-value ${entry.merit_points < 0 ? 'negative' : ''}">${entry.merit_points > 0 ? '+' : ''}${entry.merit_points}</td>
                                    <td><c:out value="${entry.remarks}" default="N/A"/></td>
                                </tr>
                            </c:forEach></c:when>
                            <c:otherwise><tr><td colspan="4" style="text-align:center;">No merit history found.</td></tr></c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>