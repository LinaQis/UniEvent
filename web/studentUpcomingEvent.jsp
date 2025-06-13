<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Student Upcoming Events</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Inter', sans-serif;
    }

    body {
      background-color: #f4f6f9;
    }

    .sidebar {
      position: fixed;
      top: 0;
      left: 0;
      width: 220px;
      height: 100vh;
      background: #ffffff;
      border-right: 1px solid #ccc;
      padding-top: 20px;
      z-index: 1000;
    }

    .sidebar .logo {
      width: 160px;
      display: block;
      margin: 0 auto 20px;
    }

    .nav-links {
      list-style: none;
      padding: 0 20px;
    }

    .nav-links li {
      margin-bottom: 15px;
    }

    .nav-links a {
      display: flex;
      align-items: center;
      color: #6b7280;
      text-decoration: none;
      padding: 10px;
      border-radius: 10px;
      transition: 0.3s;
    }

    .nav-links a img {
      width: 20px;
      height: 20px;
      margin-right: 10px;
    }

    .nav-links li.active a,
    .nav-links a:hover {
      background-color: #6c4eff;
      color: white;
    }

    .topbar {
      margin-left: 220px;
      height: 60px;
      background-color: #0f60b6;
      color: white;
      padding: 0 30px;
      display: flex;
      justify-content: flex-end;
      align-items: center;
    }
    
    .topbar-left .menu-toggle {
    background: none;
    border: none;
    color: white;
    font-size: 24px;
    cursor: pointer;
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
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
    }

    .user-info img {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      border: 2px solid white;
    }

    .sub-header {
  margin-left: 220px;
  background-color: #fcd94c; /* KEEP THIS */
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 30px;
  font-size: 14px;
  font-weight: 500;
  z-index: 999;
  position: relative;
  transition: margin-left 0.3s ease;

  /* FIX: remove white strip below */
  border-bottom: none;
  box-shadow: none;
}

    .category-dropdown-wrapper {
  display: flex;
  justify-content: flex-end;
  padding: 0 30px 0 0;   /* reduced vertical padding */
  margin-top: 0;         /* remove vertical margin */
  background: transparent;      /* ensure no background */
}


    .category-dropdown {
      position: relative;
    }

    .category-dropdown-toggle {
  background-color: #e3edf7;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 500;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 6px;
  box-shadow: none; /* remove unnecessary shadow if any */
}

    .category-dropdown-menu {
      display: none;
      position: absolute;
      right: 0;
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.2);
      margin-top: 8px;
      padding: 8px 0;
      min-width: 200px;
      max-height: 240px;
      overflow-y: auto;
    }

    .category-dropdown.show .category-dropdown-menu {
      display: block;
    }

    .category-dropdown-menu label {
      display: flex;
      align-items: center;
      padding: 10px 16px;
      font-size: 14px;
      cursor: pointer;
      transition: background 0.2s ease;
    }

    .category-dropdown-menu label:hover {
      background-color: #f3f3f3;
    }

    .category-dropdown-menu input[type="checkbox"] {
      margin-right: 10px;
      accent-color: #0f60b6;
    }

    .category-title {
      padding: 8px 16px;
      font-weight: bold;
      color: #0f60b6;
      border-bottom: 1px solid #eee;
    }

    .main-content {
      margin-left: 220px;
      padding: 50px;
      background-color: #93c2df;
      min-height: calc(100vh - 130px);
    }

    .main-content h2 {
      color: white;
      margin-bottom: 20px;
    }

    .event-list {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
    }

    .event-card {
      width: 320px;
      background-color: white;
      border-radius: 14px;
      overflow: hidden;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .event-card img {
      width: 100%;
      height: 160px;
      object-fit: cover;
    }

    .event-card-content {
      display: flex;
      align-items: center;
      padding: 12px;
    }

    .event-date {
      background-color: #0f60b6;
      color: white;
      padding: 8px 12px;
      border-radius: 8px;
      text-align: center;
      margin-right: 12px;
    }

    .event-title {
      font-size: 16px;
      font-weight: bold;
    }

    .event-meta {
      font-size: 13px;
      color: #555;
    }

    .page-footer {
      margin-left: 220px;
      padding: 15px;
      text-align: center;
      background-color: #e0e0e0;
      font-weight: 500;
      color: #111;
    }
  </style>
</head>
<body>
<%
  String studentName = "Hanna Lee";
  String studentId = "20202657196";
%>

<!-- Sidebar -->
<div class="sidebar">
  <img src="images/logo unievt.png" alt="Logo" class="logo">
  <ul class="nav-links">
    <li><a href="studentDashboard.jsp"><img src="images/db.png" alt="">Dashboard</a></li>
    <li class="active"><a href="studentEvents.jsp"><img src="images/evt.png" alt="">Events</a></li>
    <li><a href="studentFeedback.jsp"><img src="images/fbk.png" alt="">Feedback</a></li>
    <li><a href="studentAccount.jsp"><img src="images/pf.png" alt="">Account</a></li>
  </ul>
</div>

<!-- Topbar -->
<div class="topbar">
  <div class="user-info">
    <div class="user-box"><%= studentName %><br><small><%= studentId %></small></div>
    <img src="images/user.jpg" alt="User">
  </div>
    <div class="topbar-left">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
    </div>
</div>

<!-- Sub-header -->
<div class="sub-header">
  <div>Student Upcoming Events</div>
  <div>Home &gt; <strong>Events</strong></div>
</div>

<!-- Category Filter -->
<div class="category-dropdown-wrapper">
  <div class="category-dropdown">
    <button class="category-dropdown-toggle" onclick="toggleCategoryMenu()">
      <img src="images/categories.png" style="width: 18px; height: 18px;"> Categories ▾
    </button>
    <div class="category-dropdown-menu" id="categoryMenu">
      <div class="category-title">Select Categories</div>
      <label><input type="checkbox" class="category-option" checked> Academic</label>
      <label><input type="checkbox" class="category-option"> Physical</label>
      <label><input type="checkbox" class="category-option"> Social</label>
      <label><input type="checkbox" class="category-option" checked> Professional</label>
      <label><input type="checkbox" class="category-option"> Arts</label>
      <label><input type="checkbox" id="selectAll"> All</label>
    </div>
  </div>
</div>

<!-- Main Content -->
<div class="main-content">
  <h2>Upcoming Events</h2>
  <div class="event-list">
    <!-- Book Club -->
    <a href="studentEventDetails.jsp" style="text-decoration: none; color: inherit;">
      <div class="event-card">
        <img src="images/bookclub.png" alt="Book Club">
        <div class="event-card-content">
          <div class="event-date">
            <div style="font-size: 14px;">DEC</div>
            <div style="font-size: 20px; font-weight: bold;">10</div>
          </div>
          <div>
            <div class="event-title">Book Club</div>
            <div class="event-meta">Thu 07:20 · 123 Anywhere St., Any</div>
          </div>
          <div style="margin-left: auto;">
            <img src="images/group-icon.png" alt="Group" style="width: 28px; height: 28px;">
          </div>
        </div>
      </div>
    </a>

    <!-- Coding Course -->
    <div class="event-card">
      <img src="images/codingclub.jpg" alt="Coding Course">
      <div class="event-card-content">
        <div class="event-date">
          <div style="font-size: 14px;">MAY</div>
          <div style="font-size: 20px; font-weight: bold;">06</div>
        </div>
        <div>
          <div class="event-title">Coding Course</div>
          <div class="event-meta">Fri 09:20 · New York, NY</div>
        </div>
        <div style="margin-left: auto;">
          <img src="images/group-icon2.png" alt="Group" style="width: 28px; height: 28px;">
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="page-footer">
  &copy; Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
</footer>

<!-- JavaScript -->
<script>
  function toggleCategoryMenu() {
    document.querySelector('.category-dropdown').classList.toggle('show');
  }

  // Close dropdown on outside click
  document.addEventListener('click', function (e) {
    const dropdown = document.querySelector('.category-dropdown');
    if (!dropdown.contains(e.target)) {
      dropdown.classList.remove('show');
    }
  });

  // Select All logic
  document.getElementById('selectAll').addEventListener('change', function () {
    const allChecked = this.checked;
    document.querySelectorAll('.category-option').forEach(cb => {
      cb.checked = allChecked;
    });
  });

  document.querySelectorAll('.category-option').forEach(cb => {
    cb.addEventListener('change', function () {
      const allOptions = document.querySelectorAll('.category-option');
      const allChecked = Array.from(allOptions).every(cb => cb.checked);
      document.getElementById('selectAll').checked = allChecked;
    });
  });
</script>
</body>
</html>
