<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Feedback - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        /* This page reuses styles from studentFeedback.jsp, no new styles needed */
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Club Feedback" scope="request"/>
    <jsp:include page="/includes/clubSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="feedback-container">
            <div class="feedback-grid">
                <c:choose>
                    <c:when test="${not empty feedbackList}">
                        <c:forEach var="feedback" items="${feedbackList}">
                            <div class="feedback-card">
                                <div class="feedback-header">
                                    <div class="feedback-profile">
                                        <img src="${pageContext.request.contextPath}/images/user.jpg" alt="Profile">
                                        <div>
                                            <div class="feedback-name"><c:out value="${feedback.student_name}"/></div>
                                            <div class="feedback-date"><fmt:formatDate value="${feedback.feedback_date}" pattern="dd MMM, yyyy"/></div>
                                        </div>
                                    </div>
                                    <div class="tag"><c:out value="${feedback.activity_name}"/></div>
                                </div>
                                <div class="stars"><c:forEach begin="1" end="5" varStatus="loop">${loop.index <= feedback.feedback_rating ? '★' : '☆'}</c:forEach></div>
                                <p class="feedback-comment"><c:out value="${feedback.feedback_comment}"/></p>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise><p>No feedback available for this club yet.</p></c:otherwise>
                </c:choose>
            </div>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>
