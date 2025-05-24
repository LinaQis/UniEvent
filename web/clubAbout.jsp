<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Club About - The Sound Club</title>
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
        
        <!-- Main -->
        <div class="main">
            <div class="headerclub">Club About</div>

            <div style="background: url('images/about-banner.jpg') no-repeat center center; background-size: cover; height: 250px; border-radius: 0 0 40px 40px;"></div>

            <div style="padding: 30px; background-color: #fff;">
                <h2 style="font-size: 28px; font-weight: 700;">The Sound Club</h2>
                <p style="font-size: 16px; margin-bottom: 20px;">
                    Hey there! Welcome to UiTM’s The Sound Club!
                </p>
                <p style="font-size: 15px; line-height: 1.6;">
                    Love music? Whether you're just starting out or already jamming, our club is the perfect place for you!
                    We’re all about enjoying music, making new friends, and growing together.
                    Our motto? <strong>“Find Your Sound, Share Your Vibe!”</strong><br><br>
                    We believe in learning while having fun — through chill jam sessions, open mics, creative workshops,
                    and maybe even a few exciting performances. Come join the rhythm and be part of the vibe!
                </p>

                <!-- Edit Button -->
                <div style="text-align: right;">
                    <button style="padding: 10px 20px; background-color: #4285f4; color: white; border: none; border-radius: 6px; font-weight: bold; cursor: pointer;">
                        Edit
                    </button>
                </div>

                <!-- More Info / Video Section -->
                <h3 style="margin-top: 30px;">More Info</h3>
                <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 10px;">
                    <a href="https://www.youtube.com/" target="_blank" style="text-decoration: none;">
                        <div style="background-color: black; color: white; padding: 15px 25px; border-radius: 10px; display: flex; align-items: center; font-weight: 600;">
                            ▶ Watch Video
                        </div>
                    </a>
                    <img src="images/video-preview.jpg" alt="Video Preview" style="width: 200px; border-radius: 10px;">
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
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
