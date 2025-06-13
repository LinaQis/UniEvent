<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Student Events</title>
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

    .topbar {
      position: fixed;
      top: 0;
      left: 220px;
      width: calc(100% - 220px);
      background-color: #0f60b6;
      color: white;
      padding: 0px 30px;
      z-index: 1000;
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
    }

    .main-content {
      margin-left: 220px;
      padding: 150px 50px 100px;
      background-color: #93c2df;
      min-height: calc(100vh - 130px);
    }

    .page-footer {
      margin-left: 220px;
      text-align: center;
      padding: 12px;
      background-color: #e0e0e0;
      color: #111;
      font-size: 14px;
      font-weight: 500;
    }

    .event-card-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 30px;
      margin-top: 30px;
    }

    .event-card {
      background-color: white;
      border-radius: 16px;
      overflow: hidden;
      box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
      transition: transform 0.3s, box-shadow 0.3s;
      display: flex;
      flex-direction: column;
      height: 100%;
    }

    .event-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
    }

    .event-card a {
      text-decoration: none;
      color: inherit;
      display: flex;
      flex-direction: column;
      height: 100%;
    }

    .event-card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
      display: block;
    }

    .event-label {
      padding: 15px;
      font-weight: 600;
      font-size: 16px;
      text-align: center;
      background-color: #ffffff;
      flex-grow: 1;
      display: flex;
      align-items: center;
      justify-content: center;
    }
  </style>
</head>
<body>
<%
  String studentName = "Hanna Lee";
  String studentId = "20202657196";
%>

<div class="sidebar">
  <div class="sidebar-toggle">
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

<div class="topbar">
  <div class="topbar-inner">
    <div class="user-info">
      <div class="user-box"><%= studentName %><br><small><%= studentId %></small></div>
      <img src="images/user.jpg" alt="User">
    </div>
  </div>
</div>

<div class="sub-header">
  <div>Student Events</div>
  <div>Home &gt; <strong>Events</strong></div>
</div>

<div class="main-content">
  <div class="event-card-container">
    <div class="event-card">
      <a href="studentUpcomingEvent.jsp">
        <img src="images/upcoming.jpg" alt="Upcoming Event">
        <div class="event-label">Upcoming Event</div>
      </a>
    </div>
    <div class="event-card">
      <a href="studentOngoingJoinedEvent.jsp">
        <img src="images/ongoing.jpg" alt="Ongoing Joined Events">
        <div class="event-label">Ongoing Joined Events</div>
      </a>
    </div>
    <div class="event-card">
      <a href="studentClubList.jsp">
        <img src="images/club list.jpg" alt="Club List">
        <div class="event-label">Club List</div>
      </a>
    </div>
    <div class="event-card">
      <a href="studentPastJoinedEvent.jsp">
        <img src="images/past join.jpg" alt="Past Joined Events">
        <div class="event-label">Past Joined Events</div>
      </a>
    </div>
  </div>
</div>

<footer class="page-footer">
  &copy; Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
</footer>
</body>
</html>
