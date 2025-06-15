<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="topbar" id="topbar">
    <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
    <div class="topbar-inner">
        <div class="user-info">
            <div class="user-box">
                <%-- Display name based on role --%>
                <c:choose>
                    <c:when test="${sessionScope.role == 'Club Organizer'}">
                        ${sessionScope.studentName}<br><small>${sessionScope.clubName}</small>
                    </c:when>
                    <c:when test="${sessionScope.role == 'Student'}">
                        ${sessionScope.studentName}<br><small>${sessionScope.username}</small>
                    </c:when>
                    <c:when test="${sessionScope.role == 'Admin/Staff'}">
                        ${sessionScope.staffName}<br><small>${sessionScope.username}</small>
                    </c:when>
                </c:choose>
            </div>
            <img src="${pageContext.request.contextPath}/images/user.jpg" alt="User" class="profile-pic">
        </div>
    </div>
</div>

<div class="sub-header" id="subHeader">
    <div>${pageTitle}</div>
    <div>Home &gt; <strong>${pageTitle}</strong></div>
</div>
