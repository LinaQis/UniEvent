<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Club Activities - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: linear-gradient(to bottom right, #edf2f7, #dfe9f3);
        }
        .activity-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .activity-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .activity-title {
            font-size: 24px;
            font-weight: 600;
            color: #003366;
        }
        .add-activity-btn {
            background-color: #4285f4;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .activity-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .activity-card {
            background-color: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .activity-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .activity-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .status-pending { background-color: #FFD93D; color: #000; }
        .status-approved { background-color: #32d183; color: white; }
        .status-rejected { background-color: #f14c4c; color: white; }
        .activity-name { font-size: 18px; font-weight: 600; margin-bottom: 10px; color: #003366; }
        .activity-details { font-size: 14px; color: #555; margin-bottom: 8px; }
        .activity-details strong { color: #333; }
        .footer { text-align: center; padding: 20px; color: #666; }

        .popup {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 6px;
            font-weight: 600;
            z-index: 9999;
            display: none;
        }
        .popup.success { background-color: #32d183; color: white; }
        .popup.error { background-color: #f14c4c; color: white; }
    </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Club Activities</div>
        <div class="topbar-right">THE SOUND CLUB</div>
    </div>

    <div class="dashboard-container">
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="left-logo">
            <a href="clubDashboard.jsp">Dashboard</a>
            <a href="clubAboutMenu.jsp">About</a>
            <a href="clubFeedback.jsp">Feedback</a>
            <a href="#" class="active">Activity</a>
            <a href="#">Account</a>
        </div>

        <div class="main">
            <div class="activity-container">
                <div class="activity-header">
                    <h1 class="activity-title">Club Activities</h1>
                    <a class="add-activity-btn" href="clubActivityProposal.jsp">+ Add New Activity</a>
                </div>

                <div class="activity-grid">
                    <% 
                        ResultSet activities = (ResultSet) request.getAttribute("activities");
                        if (activities != null) {
                            while (activities.next()) { 
                                String status = activities.getString("STATUS");
                                String statusClass = "";
                                if ("PENDING".equals(status)) statusClass = "status-pending";
                                else if ("APPROVED".equals(status)) statusClass = "status-approved";
                                else if ("REJECTED".equals(status)) statusClass = "status-rejected";
                    %>
                    <div class="activity-card">
                        <span class="activity-status <%= statusClass %>"><%= status %></span>
                        <h3 class="activity-name"><%= activities.getString("TITLE") %></h3>
                        <p class="activity-details"><%= activities.getString("DESCRIPTION") %></p>
                        <p class="activity-details"><strong>Location:</strong> <%= activities.getString("LOCATION") %></p>
                        <p class="activity-details"><strong>Date:</strong> <%= activities.getString("START_DATE") %> to <%= activities.getString("END_DATE") %></p>
                        <p class="activity-details"><strong>Category:</strong> <%= activities.getString("CATEGORY") %></p>
                    </div>
                    <% 
                            }
                        } 
                    %>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
    </div>
</div>

<div id="popupMessage" class="popup"></div>

<script>
    function toggleSidebar() {
        document.querySelector('.sidebar').classList.toggle('collapsed');
        document.querySelector('.dashboard-container').classList.toggle('sidebar-collapsed');
    }

    window.onload = function () {
        const params = new URLSearchParams(window.location.search);
        const popup = document.getElementById("popupMessage");
        if (params.get("popup") === "success") {
            popup.textContent = "Activity proposal submitted successfully!";
            popup.className = "popup success";
            popup.style.display = "block";
        } else if (params.get("popup") === "error") {
            popup.textContent = "There was an error submitting the proposal.";
            popup.className = "popup error";
            popup.style.display = "block";
        }
        setTimeout(() => popup.style.display = "none", 4000);
    };
</script>
</body>
</html>
