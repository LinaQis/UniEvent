<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String activityId = request.getParameter("id");
    if (activityId == null) {
        response.sendRedirect("staffActivity.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Activity Details - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        .activity-details {
            background-color: white;
            border-radius: 15px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .detail-row {
            display: flex;
            margin-bottom: 15px;
        }
        
        .detail-label {
            font-weight: 600;
            width: 150px;
            color: #555;
        }
        
        .detail-value {
            flex: 1;
        }
        
        .action-buttons {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }
        
        .action-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
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
        }
        
        .back-btn {
            background-color: #4285f4;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 6px;
        }
    </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Activity Details</div>
        <div class="topbar-right">HEP STAFF</div>
    </div>

    <div class="dashboard-container">
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="left-logo">
            <a href="staffDashboard.jsp">Dashboard</a>
            <a href="staffActivity.jsp">Activity</a>
            <a href="staffReports.jsp">Reports</a>
            <a href="#">Account</a>
        </div>

        <div class="main">
            <div class="headerclub">Activity Details</div>
            
            <div class="activity-details">
                <% 
                    try {
                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                        Connection conn = DriverManager.getConnection(
                            "jdbc:derby://localhost:1527/UniEventDB", "app", "app");
                        
                        String query = "SELECT a.*, c.CLUB_NAME FROM ACTIVITIES a JOIN CLUBS c ON a.CLUB_ID = c.CLUB_ID WHERE a.ACTIVITY_ID = ?";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, Integer.parseInt(activityId));
                        ResultSet rs = stmt.executeQuery();
                        
                        if (rs.next()) {
                %>
                <div class="detail-row">
                    <div class="detail-label">Title:</div>
                    <div class="detail-value"><%= rs.getString("TITLE") %></div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Club:</div>
                    <div class="detail-value"><%= rs.getString("CLUB_NAME") %></div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Description:</div>
                    <div class="detail-value"><%= rs.getString("DESCRIPTION") %></div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Location:</div>
                    <div class="detail-value"><%= rs.getString("LOCATION") %></div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Start Date:</div>
                    <div class="detail-value"><%= rs.getString("START_DATE") %></div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">End Date:</div>
                    <div class="detail-value"><%= rs.getString("END_DATE") %></div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Category:</div>
                    <div class="detail-value"><%= rs.getString("CATEGORY") %></div>
                </div>
                
                <div class="detail-row">
                    <div class="detail-label">Status:</div>
                    <div class="detail-value">
                        <span style="color: <%= "PENDING".equals(rs.getString("STATUS")) ? "#FFD93D" : 
                                              "APPROVED".equals(rs.getString("STATUS")) ? "#32d183" : "#f14c4c" %>;
                              font-weight: 600;">
                            <%= rs.getString("STATUS") %>
                        </span>
                    </div>
                </div>
                
                <div class="action-buttons">
                    <form action="ActivityServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="approve">
                        <input type="hidden" name="activityId" value="<%= rs.getInt("ACTIVITY_ID") %>">
                        <button type="submit" class="action-btn approve-btn">Approve</button>
                    </form>
                    <form action="ActivityServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="reject">
                        <input type="hidden" name="activityId" value="<%= rs.getInt("ACTIVITY_ID") %>">
                        <button type="submit" class="action-btn reject-btn">Reject</button>
                    </form>
                    <a href="staffActivity.jsp" class="back-btn">Back to List</a>
                </div>
                <% 
                        }
                        
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
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