<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Club About - Menu</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body class="dashboard-page">
<div class="club-dashboard">

    <!-- Topbar -->
    <div class="topbar">
        <div class="topbar-left">
            <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        </div>
        <div class="topbar-right">
            <span class="club-name">THE SOUND CLUB</span>
            <img src="images/user.png" alt="Profile" class="profile-pic">
        </div>
    </div>

    <!-- Dashboard Container -->
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="img">
            <a href="clubDashboard.jsp">Dashboard</a>
            <a href="clubAboutMenu.jsp">About</a>
            <a href="clubFeedback.jsp">Feedback</a>
            <a href="clubActivity.jsp">Activity</a>
            <a href="clubAccount.jsp">Account</a>
        </div>

        <div class="main">
            <div class="headerclub">Club About</div>

            <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 30px; margin-top: 40px;">
                <a href="clubMembers.jsp" style="text-decoration: none;">
                    <div style="background: #b6daff; border-radius: 20px; padding: 30px; text-align: center;">
                        <img src="images/members-icon.png" alt="Members" style="width: 80px;"><br>
                        <div style="font-size: 18px; margin-top: 10px; color: #000;">Members</div>
                    </div>
                </a>
                <a href="clubGallery.jsp" style="text-decoration: none;">
                    <div style="background: #b6daff; border-radius: 20px; padding: 30px; text-align: center;">
                        <img src="images/gallery-icon.png" alt="Gallery" style="width: 80px;"><br>
                        <div style="font-size: 18px; margin-top: 10px; color: #000;">Gallery</div>
                    </div>
                </a>
                <a href="clubPastEvents.jsp" style="text-decoration: none;">
                    <div style="background: #b6daff; border-radius: 20px; padding: 30px; text-align: center;">
                        <img src="images/calendar-icon.png" alt="Past Events" style="width: 80px;"><br>
                        <div style="font-size: 18px; margin-top: 10px; color: #000;">Past Events</div>
                    </div>
                </a>
                <a href="clubAbout.jsp" style="text-decoration: none;">
                    <div style="background: #b6daff; border-radius: 20px; padding: 30px; text-align: center;">
                        <img src="images/info-icon.png" alt="About Us" style="width: 80px;"><br>
                        <div style="font-size: 18px; margin-top: 10px; color: #000;">About Us</div>
                    </div>
                </a>
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
