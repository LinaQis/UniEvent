<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Past Events - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        .event-card {
            background-color: #d2e9f7;
            border-radius: 20px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .event-card img {
            width: 100%;
            border-radius: 10px;
            object-fit: cover;
        }

        .event-title {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .other-events {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
    </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">

    <!-- Topbar -->
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Club Past Event</div>
        <div class="topbar-right">Home &gt; Events</div>
    </div>

    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <img src="images/logo.png" class="left-logo" alt="Logo">
            <a href="#">Dashboard</a>
            <a href="#" class="active">About</a>
            <a href="#">Feedback</a>
            <a href="#">Activity</a>
            <a href="#">Account</a>
        </div>

        <!-- Main Content -->
        <div class="main">
            <div class="headerclub">Past Events</div>

            <!-- Most Joined Event -->
            <h3 style="margin-top: 20px;">Most Joined</h3>
            <div class="event-card" style="margin-top: 10px;">
                <img src="images/event-most-joined.jpg" alt="Talent Night">
                <div><strong>Talent Night: The Sound of UiTM</strong> is our annual signature event, proudly hosted by The Sound Club. This musical talent show is dedicated to showcasing the incredible voices and musical talents of UiTM students — from singers and instrumentalists to vocal groups and creative performers.</div>
            </div>

            <!-- Other Events -->
            <h3 style="margin-top: 40px;">Others</h3>
            <div class="other-events">
                <div class="event-card">
                    <img src="images/event-melacony.jpg" alt="Malam Melacony">
                    <div><strong>Malam Melacony</strong> is The Sound Club’s annual signature event — a soulful night dedicated to music, passion, and raw talent. This talent show invites UiTM students to express themselves through heartfelt performances.</div>
                </div>
                <div class="event-card">
                    <img src="images/event-guitar.jpg" alt="Guitar Workshop">
                    <div><strong>Strum & Learn: Guitar Basics Workshop</strong> is a beginner-friendly session perfect for anyone who wants to learn guitar, improve their basics, and play simple songs. No experience needed — just bring your passion for music!</div>
                </div>
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
