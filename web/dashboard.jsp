<%@ page session="true" %>
<%
    String user = (String) session.getAttribute("username");
    if(user == null){
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h2>Welcome, <%= user %>!</h2>
</body>
</html>
