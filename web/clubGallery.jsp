<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Gallery - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .gallery-grid img {
            width: 100%;
            border-radius: 15px;
            height: 180px;
            object-fit: cover;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .edit-btn {
            background-color: #4285f4;
            color: white;
            padding: 8px 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            float: right;
            cursor: pointer;
        }
    </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">

    <!-- Topbar -->
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Club Gallery</div>
        <div class="topbar-right">Home &gt; Gallery</div>
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
            <div class="headerclub">Gallery</div>

            <div style="margin-top: 20px;">
                <button class="edit-btn">Edit</button>
            </div>

            <!-- Gallery Grid -->
            <div class="gallery-grid">
                <img src="images/gallery1.jpg" alt="Event 1">
                <img src="images/gallery2.jpg" alt="Event 2">
                <img src="images/gallery3.jpg" alt="Event 3">
                <img src="images/gallery4.jpg" alt="Event 4">
                <img src="images/gallery5.jpg" alt="Event 5">
                <img src="images/gallery6.jpg" alt="Event 6">
                <img src="images/gallery7.jpg" alt="Event 7">
                <img src="images/gallery8.jpg" alt="Event 8">
                <img src="images/gallery9.jpg" alt="Event 9">
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
