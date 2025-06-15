<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Club Members - UniEvent</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .members-container{background-color:#fff;padding:30px;border-radius:12px;box-shadow:0 5px 15px rgba(0,0,0,.1);width:100%}.search-bar{margin-bottom:25px;display:flex;gap:10px}.search-bar input[type=text]{flex-grow:1;padding:12px;border:1px solid #ddd;border-radius:8px;font-size:1em}.search-bar button{background-color:#6b46f2;color:#fff;padding:10px 20px;border:none;border-radius:8px;cursor:pointer}.members-table{width:100%;border-collapse:collapse;margin-top:20px}.members-table th,.members-table td{padding:12px 15px;text-align:left;border-bottom:1px solid #ddd}.members-table th{background-color:#f2f2f2;font-weight:600;text-transform:uppercase;font-size:.9em}.members-table tr:hover{background-color:#f9f9f9}.member-profile-img{width:40px;height:40px;border-radius:50%;object-fit:cover;vertical-align:middle;margin-right:10px}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Club Members" scope="request"/>
    <jsp:include page="/includes/clubSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="members-container">
            <div class="search-bar">
                <input type="text" id="memberSearch" onkeyup="filterMembers()" placeholder="Search by name or ID...">
            </div>
            <div class="members-table-container">
                <table class="members-table" id="membersTable">
                    <thead><tr><th>Name</th><th>Student ID</th><th>Email</th><th>Phone</th></tr></thead>
                    <tbody>
                        <c:forEach var="member" items="${members}">
                            <tr>
                                <td><img src="${pageContext.request.contextPath}/images/user.jpg" class="member-profile-img"><c:out value="${member.student_name}"/></td>
                                <td><c:out value="${member.student_no}"/></td>
                                <td><c:out value="${member.student_email}"/></td>
                                <td><c:out value="${member.student_phonenum}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
    <script>
        function filterMembers(){const t=document.getElementById("memberSearch").value.toUpperCase(),e=document.getElementById("membersTable").getElementsByTagName("tr");for(let n=1;n<e.length;n++){let d=e[n].getElementsByTagName("td")[0],a=e[n].getElementsByTagName("td")[1];(d.textContent||d.innerText).toUpperCase().indexOf(t)>-1||(a.textContent||a.innerText).toUpperCase().indexOf(t)>-1?e[n].style.display="":e[n].style.display="none"}}
    </script>
</body>
</html>