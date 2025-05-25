<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Student Past Joined Event</title>
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
    <li  class="active"><a href="studentEvents.jsp"><img src="images/evt.png" alt=""><span>Events</span></a></li>
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
  <div>Student Past Joined Event</div>
  <div>Home &gt; <strong>Events</strong></div>
</div>

<div class="main-content" id="mainContent">
<h2 style="color: white; margin-bottom: 30px;">Past Joined Event</h2>

<div style="display: flex; flex-wrap: wrap; gap: 40px;">

  <!-- Book Club Card -->
  <div style="width: 320px; background-color: white; border-radius: 14px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
    <img src="images/bookclub.png" alt="Book Club" style="width: 100%; height: 160px; object-fit: cover;">
    <div style="display: flex; align-items: center; padding: 12px;">
      <div style="background-color: #0f60b6; color: white; padding: 8px 12px; border-radius: 8px; text-align: center; margin-right: 12px;">
        <div style="font-size: 14px;">DEC</div>
        <div style="font-size: 20px; font-weight: bold;">10</div>
      </div>
      <div>
        <div style="font-size: 16px; font-weight: bold;">Book Club</div>
        <div style="font-size: 13px; color: #555;">Thu 07:20 · 123 Anywhere St., Any</div>
      </div>
      <div style="margin-left: auto;">
        <img src="images/group-icon.png" alt="Group" style="width: 28px; height: 28px;">
      </div>
    </div>
  </div>

  <!-- Coding Course Card -->
  <div style="width: 320px; background-color: white; border-radius: 14px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
    <img src="images/codingclub.jpg" alt="Coding" style="width: 100%; height: 160px; object-fit: cover;">
    <div style="display: flex; align-items: center; padding: 12px;">
      <div style="background-color: #0f60b6; color: white; padding: 8px 12px; border-radius: 8px; text-align: center; margin-right: 12px;">
        <div style="font-size: 14px;">MAY</div>
        <div style="font-size: 20px; font-weight: bold;">06</div>
      </div>
      <div>
        <div style="font-size: 16px; font-weight: bold;">Coding Course</div>
        <div style="font-size: 13px; color: #555;">Fri 09:20 · New York, NY</div>
      </div>
      <div style="margin-left: auto;">
        <img src="images/group-icon2.png" alt="Group" style="width: 28px; height: 28px;">
      </div>
    </div>
  </div>

  <!-- Dropdown (Floating Right) -->
  <div style="margin-left: auto;">
    <div style="background-color: white; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); padding: 12px 14px; width: 200px;">
      <div style="font-weight: 600; font-size: 14px; margin-bottom: 10px;">Categories</div>
      <div><input type="checkbox" checked> Academic</div>
      <div><input type="checkbox"> Physical</div>
      <div><input type="checkbox"> Social</div>
      <div><input type="checkbox" checked> Professional</div>
      <div><input type="checkbox"> Arts</div>
      <div><input type="checkbox"> All</div>
    </div>
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
