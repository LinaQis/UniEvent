<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Past Events - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to bottom right, #d6e6f5, #a8c9f0);
        }

        .main {
            padding: 20px;
        }

        .headerclub {
            background-color: #FFD93D;
            padding: 10px 15px;
            font-weight: 600;
            font-size: 16px;
            color: #000;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        h3 {
            font-size: 15px;
            font-weight: 600;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .event-card {
            background-color: #b8dcf5;
            border-radius: 15px;
            padding: 12px;
            display: flex;
            flex-direction: column;
            align-items: center;
            box-shadow: 0 3px 6px rgba(0,0,0,0.04);
            min-height: 220px;
            max-width: 420px;
        }

        .event-card img {
            width: 100%;
            height: 150px;
            border-radius: 10px;
            object-fit: cover;
        }

        .event-card strong {
            display: block;
            margin: 8px 0 4px;
            font-weight: 600;
            font-size: 13px;
        }

        .event-card div {
            font-size: 12px;
            text-align: justify;
            color: #333;
        }

        .most-joined {
            max-width: 420px;
        }

        .other-events {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
            margin-top: 15px;
        }

        .footer {
            text-align: center;
            padding: 15px;
            font-size: 11px;
            background-color: #f4f4f4;
            color: #555;
        }
    </style>
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

        <!-- Main Content -->
        <div class="main">
            <div class="headerclub">Past Events</div>

            <!-- Most Joined Event -->
            <h3>Most Joined</h3>
            <div class="event-card most-joined">
                <img src="images/event-most-joined.jpg" alt="Talent Night">
                <div>
                    <strong>Talent Night: The Sound of UiTM</strong>
                    is our annual signature event, proudly hosted by The Sound Club. This musical talent show is dedicated to showcasing the incredible voices and musical talents of UiTM students.
                </div>
            </div>

            <!-- Other Events -->
            <h3>Others</h3>
            <div class="other-events">
                <div class="event-card most-joined">
                    <img src="images/event-melacony.jpeg" alt="Malam Melacony">
                    <div>
                        <strong>Malam Melacony</strong>
                        is a soulful night dedicated to music, passion, and talent. UiTM students showcase their emotions through heartfelt performances.
                    </div>
                </div>
                <div class="event-card most-joined">
                    <img src="images/event-guitar.jpeg" alt="Guitar Workshop">
                    <div>
                        <strong>Strum & Learn: Guitar Basics Workshop</strong>
                        is a beginner-friendly session to learn chords and strumming. Just bring your love for music!
                    </div>
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
