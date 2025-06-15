<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Club Dashboard - UniEvent</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .dashboard-cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:20px;margin-bottom:30px}.card{background-color:#fff;padding:25px;border-radius:12px;box-shadow:0 4px 10px rgba(0,0,0,.08);text-align:center;transition:transform .2s ease-in-out}.card:hover{transform:translateY(-5px)}.card h3{font-size:1.1em;color:#555;margin-bottom:10px;font-weight:600}.card .value{font-size:2.5em;font-weight:700;color:#6b46f2}.dashboard-sections{display:grid;grid-template-columns:2fr 1fr;gap:30px}.section-header{font-size:1.5em;color:#333;margin-bottom:20px;font-weight:600;border-bottom:2px solid #eee;padding-bottom:10px}.list-container{background-color:#fff;padding:25px;border-radius:12px;box-shadow:0 4px 10px rgba(0,0,0,.08)}.list-container ul{list-style:none;padding:0}.list-container li{display:flex;align-items:center;padding:12px 0;border-bottom:1px solid #eee}.list-container li:last-child{border-bottom:none}.item-info{flex-grow:1;margin-left:15px}.item-title{font-weight:600;color:#333}.item-meta{font-size:.9em;color:#777}.item-icon{width:40px;height:40px;background-color:#e6e6fa;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.2em;color:#6b46f2;flex-shrink:0}.no-data-message{text-align:center;padding:30px;color:#777;font-style:italic}
        @media (max-width:992px){.dashboard-sections{grid-template-columns:1fr}}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Club Dashboard" scope="request"/>
    <jsp:include page="/includes/clubSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />

        <div class="content-header">
            <h1>Welcome, <c:out value="${sessionScope.studentName}"/>!</h1>
            <p>Here's a quick overview of your club's activities.</p>
        </div>

        <div class="dashboard-cards">
            <div class="card">
                <h3>Upcoming Events</h3>
                <div class="value"><c:out value="${upcomingEvents.size()}"/></div>
            </div>
            <div class="card">
                <h3>Total Members</h3>
                <div class="value"><c:out value="${totalMembers}"/></div>
            </div>
            <div class="card">
                <h3>Approved Activities</h3>
                <div class="value"><c:out value="${approvedActivitiesCount}"/></div>
            </div>
            <div class="card">
                <h3>Pending Proposals</h3>
                <div class="value"><c:out value="${pendingActivitiesCount}"/></div>
            </div>
        </div>

        <div class="dashboard-sections">
            <div class="list-container">
                <h2 class="section-header">Upcoming Events</h2>
                <ul>
                    <c:choose>
                        <c:when test="${not empty upcomingEvents}"><c:forEach var="event" items="${upcomingEvents}">
                            <li>
                                <div class="item-icon">📅</div>
                                <div class="item-info">
                                    <div class="item-title"><c:out value="${event.activity_name}"/></div>
                                    <div class="item-meta">
                                        <%-- THIS LINE IS CORRECTED --%>
                                        <fmt:formatDate value="${event.activity_startdate}" pattern="MMMM dd, yyyy"/> - <c:out value="${event.activity_location}"/>
                                    </div>
                                </div>
                            </li>
                        </c:forEach></c:when>
                        <c:otherwise><p class="no-data-message">No upcoming events.</p></c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="list-container">
                <h2 class="section-header">Newest Members</h2>
                <ul>
                    <c:choose>
                        <c:when test="${not empty newMembers}"><c:forEach var="member" items="${newMembers}">
                           <li>
                               <div class="item-icon">👤</div>
                               <div class="item-info">
                                   <div class="item-title"><c:out value="${member.student_name}"/></div>
                                   <div class="item-meta"><c:out value="${member.student_no}"/></div>
                               </div>
                           </li>
                        </c:forEach></c:when>
                        <c:otherwise><p class="no-data-message">No new members.</p></c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
</body>
</html>
