<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Member - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body class="dashboard-page">
<div class="club-dashboard">

    <!-- Topbar -->
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Club Dashboard</div>
        <div class="topbar-right">
            THE SOUND CLUB
            <div style="font-size: 12px;">Home &gt; <strong>New Member</strong></div>
        </div>
    </div>

    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="left-logo">
            <a href="#">Dashboard</a>
            <a href="#">About</a>
            <a href="#">Feedback</a>
            <a href="#">Activity</a>
            <a href="#">Account</a>
        </div>

        <!-- Main Content -->
        <div class="main">
            <!-- Sub-header -->
            <div class="headerclub">New Member</div>

            <!-- Search -->
            <div style="margin: 20px 0;">
                <input type="text" placeholder="Search for Application here" style="width: 100%; padding: 12px; border-radius: 6px; border: 1px solid #ccc; font-family: 'Poppins', sans-serif;">
            </div>

            <!-- Member List -->
            <div class="members-list" style="background: #fff; padding: 20px; border-radius: 20px; box-shadow: 0 0 10px rgba(0,0,0,0.05);">
                <h3 style="margin-bottom: 20px;">New Member</h3>

                <%-- Dummy members --%>
                <%
                    for (int i = 0; i < 8; i++) {
                        String name = (i % 3 == 0) ? "Aminah Awang" : (i % 3 == 1) ? "Siti Zubaidah Anhar" : "Molek Fatimah Hasbullah";
                        String id = (i % 3 == 0) ? "2025667799" : (i % 3 == 1) ? "2024090966" : "2024666675";
                %>
                <div style="display: flex; justify-content: space-between; align-items: center; padding: 12px 20px; border: 1px solid #eee; border-radius: 10px; margin-bottom: 15px;">
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <img src="images/profile.png" alt="Profile" style="width: 50px; height: 50px; border-radius: 50%;">
                        <div>
                            <div style="font-weight: 600;"><%= name %></div>
                            <div style="font-size: 12px; color: #777;"><%= id %></div>
                        </div>
                    </div>
                    <div>
                        <button class="approve">Approve</button>
                        <button class="reject">Reject</button>
                    </div>
                </div>
                <% } %>

                <!-- Pagination -->
                <div style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center; font-size: 13px; color: #555;">
                    <div>Showing data 1 to 8 of 70 members</div>
                    <div>
                        <button style="padding: 6px 10px;">&lt;</button>
                        <button style="padding: 6px 12px; background-color: #6C63FF; color: white; border-radius: 5px;">1</button>
                        <button style="padding: 6px 12px;">2</button>
                        <button style="padding: 6px 12px;">3</button>
                        <button style="padding: 6px 10px;">&gt;</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer" style="text-align: center; font-size: 12px; color: #666; padding: 15px 0;">
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
