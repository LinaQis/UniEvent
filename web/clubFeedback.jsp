<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Feedback - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: linear-gradient(to bottom right, #D6E6FF, #A8C9F0);
        }

        .topbar {
            background-color: #084D8A;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 30px;
            font-weight: 600;
        }

        .topbar-left {
            background: #FFD93D;
            color: #000;
            padding: 6px 14px;
            border-radius: 5px;
        }

        .topbar-right {
            font-size: 14px;
        }

        .sidebar {
            width: 220px;
            height: 100vh;
            background-color: #fff;
            padding-top: 20px;
            position: fixed;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.05);
        }

        .sidebar a {
            display: block;
            padding: 12px 25px;
            color: #333;
            text-decoration: none;
            font-weight: 600;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #6B46F2;
            color: white;
            border-radius: 5px;
        }

        .content {
            margin-left: 240px;
            padding: 30px;
        }

        .headerclub {
            background-color: #FFD93D;
            padding: 12px 20px;
            font-weight: 600;
            font-size: 16px;
            color: #000;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        h2 {
            font-weight: 600;
            margin-bottom: 20px;
        }

        .feedback-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 20px;
        }

        .feedback-card {
            background: white;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.05);
        }

        .feedback-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .feedback-profile {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .feedback-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .feedback-name {
            font-weight: 600;
        }

        .tag {
            background-color: #C6C2DD;
            color: #333;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        .stars {
            color: #FFD93D;
            margin: 10px 0;
        }

        .pagination {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .pagination button {
            background-color: #eee;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
        }

        .pagination button.active {
            background-color: #6B46F2;
            color: white;
        }

        .footer {
            text-align: center;
            font-size: 12px;
            color: #666;
            margin-top: 40px;
            padding: 15px 0;
        }
    </style>
</head>
<body>
    <div class="topbar">
        <div class="topbar-left">Club Feedback</div>
        <div class="topbar-right">THE SOUND CLUB</div>
    </div>

    <div class="sidebar">
        <img src="images/logo.png" alt="UniEvent Logo" style="width: 120px; display: block; margin: 0 auto 30px;">
        <a href="#">Dashboard</a>
        <a href="#">About</a>
        <a href="#">Feedback</a>
        <a href="#">Activity</a>
        <a href="#">Account</a>
    </div>

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
                                <div class="stars">
                                    ★★★★★
                                </div>
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

        <div class="footer">
            © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
        </div>
    </div>
</body>
</html>
