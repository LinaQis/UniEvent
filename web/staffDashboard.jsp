<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .dashboard-card {
            background-color: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .card-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #555;
        }
        
        .card-value {
            font-size: 28px;
            font-weight: bold;
            color: #003366;
        }
        
        .request-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        
        .request-info {
            flex: 1;
        }
        
        .request-name {
            font-weight: 600;
        }
        
        .request-id {
            font-size: 12px;
            color: #777;
        }
        
        .request-actions {
            display: flex;
            gap: 10px;
        }
        
        .approve-btn {
            background-color: #32d183;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .reject-btn {
            background-color: #f14c4c;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Staff Dashboard</div>
        <div class="topbar-right">HEP STAFF</div>
    </div>

    <div class="dashboard-container">
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="left-logo">
            <a href="staffDashboard.jsp" class="active">Dashboard</a>
            <a href="staffActivity.jsp">Activity</a>
            <a href="staffReports.jsp">Reports</a>
            <a href="#">Account</a>
        </div>

        <div class="main">
            <div class="headerclub">Staff Dashboard</div>
            
            <div class="dashboard-cards">
                <div class="dashboard-card">
                    <div class="card-title">Pending Activities</div>
                    <div class="card-value">12</div>
                </div>
                
                <div class="dashboard-card">
                    <div class="card-title">Approved Activities</div>
                    <div class="card-value">45</div>
                </div>
                
                <div class="dashboard-card">
                    <div class="card-title">Total Clubs</div>
                    <div class="card-value">28</div>
                </div>
                
                <div class="dashboard-card">
                    <div class="card-title">Pending Staff Requests</div>
                    <div class="card-value">5</div>
                </div>
            </div>
            
            <div class="dashboard-card" style="margin-top: 30px;">
                <div class="card-title">Staff Registration Requests</div>
                
                <% 
                    ResultSet staffRequests = (ResultSet) request.getAttribute("staffRequests");
                    if (staffRequests != null) {
                        while (staffRequests.next()) { 
                %>
                <div class="request-item">
                    <div class="request-info">
                        <div class="request-name"><%= staffRequests.getString("NAME") %></div>
                        <div class="request-id"><%= staffRequests.getString("STAFF_ID") %></div>
                    </div>
                    <div class="request-actions">
                        <form action="StaffServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="approve">
                            <input type="hidden" name="requestId" value="<%= staffRequests.getInt("REQUEST_ID") %>">
                            <button type="submit" class="approve-btn">Approve</button>
                        </form>
                        <form action="StaffServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="reject">
                            <input type="hidden" name="requestId" value="<%= staffRequests.getInt("REQUEST_ID") %>">
                            <button type="submit" class="reject-btn">Reject</button>
                        </form>
                    </div>
                </div>
                <% 
                        }
                    } 
                %>
            </div>
        </div>
    </div>
    
    <div class="footer">
        © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
    </div>
</div>

<script>
    function toggleSidebar() {
        document.querySelector('.sidebar').classList.toggle('collapsed');
        document.querySelector('.dashboard-container').classList.toggle('sidebar-collapsed');
    }
</script>
</body>
</html>