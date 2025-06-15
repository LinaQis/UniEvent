<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Details - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .club-details-container{background-color:#fff;padding:30px;border-radius:12px;box-shadow:0 5px 15px rgba(0,0,0,.1);width:100%;max-width:800px;margin:20px auto;display:flex;flex-direction:column;align-items:center}.club-header{text-align:center;margin-bottom:25px}.club-logo{width:120px;height:120px;border-radius:50%;object-fit:cover;border:4px solid #6b46f2;padding:5px;background-color:#fff;margin-bottom:15px}.club-name{font-size:2.2em;color:#333;margin-bottom:5px;font-weight:700}.club-category{font-size:1.1em;color:#6b46f2;font-weight:600;margin-bottom:20px}.club-info-section{width:100%;margin-top:20px;text-align:left}.club-info-section h3{font-size:1.5em;color:#333;margin-bottom:15px;border-bottom:2px solid #eee;padding-bottom:8px}.club-info-item{margin-bottom:15px}.club-info-item label{font-weight:600;color:#555;display:block;margin-bottom:5px}.club-info-item p{color:#777;line-height:1.6;margin:0 0 0 10px}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Club Details" scope="request"/>
    <jsp:include page="/includes/studentSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="club-details-container">
            <c:choose>
                <c:when test="${not empty club}">
                    <img src="${pageContext.request.contextPath}/${club.logo_path}" alt="${club.club_name} Logo" class="club-logo" onerror="this.onerror=null;this.src='https://placehold.co/120x120/cccccc/333333?text=No+Logo';">
                    <h2 class="club-name"><c:out value="${club.club_name}"/></h2>
                    <p class="club-category"><c:out value="${club.club_category}"/></p>
                    <div class="club-info-section">
                        <h3>About Us</h3>
                        <div class="club-info-item">
                            <label>Description:</label>
                            <p><c:out value="${club.club_desc}"/></p>
                        </div>
                         <div class="club-info-item">
                            <label>Club President ID:</label>
                            <p><c:out value="${club.club_presidentID}"/></p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise><p>Club details not found.</p></c:otherwise>
            </c:choose>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>