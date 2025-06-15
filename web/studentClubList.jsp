<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="[http://java.sun.com/jsp/jstl/core](http://java.sun.com/jsp/jstl/core)" %>
<jsp:useBean id="clubs" scope="request" type="java.util.List<model.Club>"/>
<jsp:useBean id="categoryName" scope="request" type="java.lang.String"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Club List</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <jsp:include page="studentSidebar.jsp" />
    <div class="topbar-container">
        <div class="sub-header">
            <div>Club List: ${empty categoryName ? 'All' : categoryName}</div>
            <div>Home &gt; Events &gt; <strong>Club List</strong></div>
        </div>
    </div>

    <div class="main-content">
         <div class="category-grid-container">
            <!-- This part can be made dynamic if you have a CategoryDAO -->
            <a href="studentClubList?category=5" class="category-grid-item">Sports & Recreation</a>
            <a href="studentClubList?category=1" class="category-grid-item">Student Bodies</a>
            <a href="studentClubList?category=6" class="category-grid-item">Academical Society</a>
             <!-- Add other categories here -->
        </div>

        <div class="club-list-container">
             <c:forEach var="club" items="${clubs}">
                <a href="clubDetails?clubId=${club.club_id}" class="club-card-link">
                    <div class="club-card">
                        <img src="${club.logo_path}" alt="${club.club_name}">
                        <div class="club-name">${club.club_name}</div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>

    <jsp:include page="studentFooter.jsp" />
</body>
</html>