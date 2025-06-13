<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Student Club List Categories</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter&display=swap">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Inter', sans-serif;
    }

    body {
      background-color: #f4f6f9;
      padding-top: 60px;
      display: flex;
      flex-direction: column;
    }

    .sidebar {
      position: fixed;
      top: 0;
      left: 0;
      width: 220px;
      height: 100vh;
      background-color: #ffffff;
      border-right: 1px solid #ccc;
      padding-top: 10px;
      z-index: 1000;
      transition: width 0.3s ease;
    }

    .sidebar.collapsed {
      width: 60px;
    }

    .sidebar-toggle {
      display: flex;
      justify-content: center;
      padding: 10px 0;
      cursor: pointer;
    }

    .sidebar-toggle img {
      width: 24px;
      height: 24px;
    }

    .logo-container {
      text-align: center;
      padding: 10px 0;
    }

    .sidebar.collapsed .logo-container,
    .sidebar.collapsed .arrow,
    .sidebar.collapsed .nav-links a span {
      display: none;
    }

    .logo {
      width: 160px;
      height: auto;
    }

    .nav-links {
      list-style: none;
      padding: 0;
      margin-top: 20px;
    }

    .nav-links li {
      margin-bottom: 10px;
    }

    .nav-links a {
      display: flex;
      align-items: center;
      padding: 12px 20px;
      text-decoration: none;
      color: #6b7280;
      font-weight: 500;
      transition: background 0.3s, color 0.3s;
    }

    .nav-links a:hover {
      background-color: #f0f0f0;
      color: #0f60b6;
      border-radius: 10px;
    }

    .nav-links li.active a {
      background-color: #6c4eff;
      color: #ffffff;
      border-radius: 10px;
    }

    .nav-links img {
      width: 20px;
      height: 20px;
      margin-right: 15px;
    }

    .arrow {
      margin-left: auto;
      font-size: 16px;
    }

    .topbar {
      position: fixed;
      top: 0;
      left: 220px;
      width: calc(100% - 220px);
      background-color: #0f60b6;
      color: white;
      padding: 0px 30px;
      z-index: 1000;
      transition: left 0.3s ease, width 0.3s ease;
    }

    .sidebar.collapsed ~ .topbar {
      left: 60px;
      width: calc(100% - 60px);
    }

    .topbar-inner {
      display: flex;
      justify-content: flex-end;
      align-items: center;
      height: 60px;
    }

    .user-info {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .user-box {
      background-color: white;
      color: #0f60b6;
      padding: 6px 12px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 13px;
      line-height: 1.3;
      cursor: pointer;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
    }

    .user-info img {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      border: 2px solid white;
      cursor: pointer;
    }

    .sub-header {
      margin-left: 220px;
      background-color: #fcd94c;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px 30px;
      font-size: 14px;
      font-weight: 500;
      z-index: 999;
      position: relative;
      transition: margin-left 0.3s ease;
    }

    .sidebar.collapsed ~ .sub-header {
      margin-left: 60px;
    }

    .main-content {
      margin-left: 220px;
      padding: 150px 50px 100px;
      background-color: #93c2df;
      min-height: calc(100vh - 130px);
      transition: margin-left 0.3s ease;
    }

    .sidebar.collapsed ~ .main-content {
      margin-left: 60px;
    }

    .page-footer {
      margin-left: 220px;
      text-align: center;
      padding: 12px;
      background-color: #e0e0e0;
      color: #111;
      font-size: 14px;
      font-weight: 500;
      transition: margin-left 0.3s ease;
    }

    .sidebar.collapsed ~ .page-footer {
      margin-left: 60px;
    }

    .profile-dropdown {
  position: relative;
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
}

.dropdown-menu {
  display: none;
  position: absolute;
  top: 100%;
  right: 0;
  background: white;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  padding: 8px 10px;
  z-index: 9999;
  min-width: 120px;
}

.dropdown-menu a {
  text-decoration: none;
  color: #0f60b6;
  padding: 6px 12px;
  display: block;
  font-weight: 500;
  border-radius: 6px;
}

.dropdown-menu a:hover {
  background-color: #f0f0f0;
}


  </style>
</head>
<body>
<%
  String studentName = "Hanna Lee";
  String studentId = "20202657196";
%>

<div class="sidebar" id="sidebar">
  <div class="sidebar-toggle" onclick="toggleSidebar()">
    <img src="images/sideB.png" alt="Toggle">
  </div>
  <div class="logo-container">
    <img src="images/logo unievt.png" alt="Logo" class="logo">
  </div>
  <ul class="nav-links">
   <li><a href="studentDashboard.jsp"><img src="images/db.png" alt=""><span>Dashboard</span></a></li>
    <li class="active"><a href="studentEvents.jsp"><img src="images/evt.png" alt=""><span>Events</span></a></li>
    <li><a href="studentFeedback.jsp"><img src="images/fbk.png" alt=""><span>Feedback</span></a></li>
    <li><a href="studentAccount.jsp"><img src="images/pf.png" alt=""><span>Account</span></a></li>
  </ul>
</div>

<div class="topbar" id="topbar">
  <div class="topbar-inner">
    <div class="user-info">
        
      <div class="user-box"><%= studentName %><br><small><%= studentId %></small></div>
      <img src="images/user.jpg" alt="User">
    </div>
  </div>
</div>

<div class="sub-header" id="subHeader">
  <div>Student Club List</div>
  <div>Home &gt; <strong>Events</strong></div>
</div>

 <div class="main-content" id="mainContent" style="background-color: #fff; color: #111; font-family: 'Inter', sans-serif;">
<div style="padding: 30px; background-color: #fff; border-radius: 10px; margin-bottom: 40px;">
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
  <div style="text-align: right; margin-top: 20px;">
    <button style="padding: 10px 20px; background-color: #4285f4; color: white; border: none; border-radius: 6px; font-weight: bold; cursor: pointer;">
      Edit
    </button>
  </div>

  <!-- More Info / Video Section -->
  <h3 style="margin-top: 30px; font-size: 20px;">More Info</h3>
  <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 10px; flex-wrap: wrap; gap: 20px;">
    <a href="https://www.youtube.com/" target="_blank" style="text-decoration: none;">
      <div style="background-color: black; color: white; padding: 15px 25px; border-radius: 10px; display: flex; align-items: center; font-weight: 600;">
        ▶️ Watch Video
      </div>
    </a>
    <img src="images/video-preview.jpg" alt="Video Preview" style="width: 200px; border-radius: 10px;">
  </div>
</div>

</div>



<footer class="page-footer">
  &copy; Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
</footer>

<script>
  function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const topbar = document.getElementById('topbar');
    const subHeader = document.getElementById('subHeader');
    const mainContent = document.getElementById('mainContent');
    const footer = document.getElementById('footer');

    sidebar.classList.toggle('collapsed');
    topbar.classList.toggle('shifted');
    subHeader.classList.toggle('shifted');
    mainContent.classList.toggle('shifted');
    footer.classList.toggle('shifted');
  }
</script>
</body>
</html>
