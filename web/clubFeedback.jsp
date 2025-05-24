<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Feedback - UniEvent</title>
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
        <img src="images/logo.png" alt="Logo" class="left-logo">
        <a href="clubDashboard.jsp">Dashboard</a>
        <a href="clubAboutMenu.jsp">About</a>
        <a href="clubFeedback.jsp" class="active">Feedback</a>
        <a href="clubActivity.jsp">Activity</a>
        <a href="clubAccount.jsp">Account</a>
    </div>

    <!-- Content -->
    <div class="content">
        <div class="headerclub">Review and Rating</div>
        <div class="feedback-grid">
            <% for (int i = 0; i < 6; i++) { %>
                <div class="feedback-card">
                    <div class="feedback-header">
                        <div class="feedback-profile">
                            <img src="images/profile1.png" alt="Profile">
                            <div>
                                <div class="feedback-name">KaiB . 22 Jul</div>
                                <div class="stars">★★★★★</div>
                            </div>
                        </div>
                        <div class="tag">Let's read together</div>
                    </div>
                    <p style="margin-top: 10px; font-size: 14px; line-height: 1.5;">
                        She truly gave us peace of mind while on holiday, knowing our furbabies were in good hands. We also kept looking forward to her cute updates! You can tell she's a natural with animals. I’d definitely book her again.
                    </p>
                </div>
            <% } %>
        </div>

        <div class="pagination">
            <button>&lt;</button>
            <button class="active">1</button>
            <button>2</button>
            <button>3</button>
            <button>&gt;</button>
        </div>

        <div class="feedbackfooter">
                © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
        </div>
    </div>
</div>
</div>
</body>
</html>
