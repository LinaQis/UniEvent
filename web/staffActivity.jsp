<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Activities - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        .activity-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        .activity-table th, .activity-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .activity-table th {
            background-color: #f5f5f5;
            font-weight: 600;
        }
        
        .activity-table tr:hover {
            background-color: #f9f9f9;
        }
        
        .status-pending {
            color: #FFD93D;
            font-weight: 600;
        }
        
        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
        }
        
        .approve-btn {
            background-color: #32d183;
            color: white;
        }
        
        .reject-btn {
            background-color: #f14c4c;
            color: white;
            margin-left: 5px;
        }
        
        .view-btn {
            background-color: #4285f4;
            color: white;
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
        }
    </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Staff Activities</div>
        <div class="topbar-right">HEP STAFF</div>
    </div>

    <div class="dashboard-container">
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="left-logo">
            <a href="staffDashboard.jsp">Dashboard</a>
            <a href="#" class="active">Activity</a>
            <a href="staffReports.jsp">Reports</a>
            <a href="#">Account</a>
        </div>

        <div class="main">
            <div class="headerclub">Pending Activities</div>
            
            <table class="activity-table">
                <thead>
                    <tr>
                        <th>Activity Title</th>
                        <th>Club</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        ResultSet pendingActivities = (ResultSet) request.getAttribute("pendingActivities");
                        if (pendingActivities != null) {
                            while (pendingActivities.next()) { 
                    %>
                    <tr>
                        <td><%= pendingActivities.getString("TITLE") %></td>
                        <td>
                            <% 
                                // Get club name
                                try {
                                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                                    Connection conn = DriverManager.getConnection(
                                        "jdbc:derby://localhost:1527/UniEventDB", "app", "app");
                                    
                                    String clubQuery = "SELECT CLUB_NAME FROM CLUBS WHERE CLUB_ID = ?";
                                    PreparedStatement clubStmt = conn.prepareStatement(clubQuery);
                                    clubStmt.setInt(1, pendingActivities.getInt("CLUB_ID"));
                                    ResultSet clubRs = clubStmt.executeQuery();
                                    
                                    if (clubRs.next()) {
                                        out.print(clubRs.getString("CLUB_NAME"));
                                    }
                                    
                                    clubRs.close();
                                    clubStmt.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </td>
                        <td><%= pendingActivities.getString("START_DATE") %></td>
                        <td class="status-pending"><%= pendingActivities.getString("STATUS") %></td>
                        <td>
                            <a href="staffActivityDetails.jsp?id=<%= pendingActivities.getInt("ACTIVITY_ID") %>" class="view-btn">View</a>
                            <form action="ActivityServlet" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="approve">
                                <input type="hidden" name="activityId" value="<%= pendingActivities.getInt("ACTIVITY_ID") %>">
                                <button type="submit" class="action-btn approve-btn">Approve</button>
                            </form>
                            <form action="ActivityServlet" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="reject">
                                <input type="hidden" name="activityId" value="<%= pendingActivities.getInt("ACTIVITY_ID") %>">
                                <button type="submit" class="action-btn reject-btn">Reject</button>
                            </form>
                        </td>
                    </tr>
                    <% 
                            }
                        } 
                    %>
                </tbody>
            </table>
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