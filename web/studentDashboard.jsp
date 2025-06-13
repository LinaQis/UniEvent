<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Dashboard</title>
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
      background: #fff;
      border-right: 1px solid #ccc;
      z-index: 1000;
    }

    .nav-links {
      list-style: none;
      padding: 0;
      margin-top: 20px;
    }

    .nav-links li a {
      display: flex;
      align-items: center;
      padding: 12px 20px;
      text-decoration: none;
      color: #6b7280;
    }

    .nav-links li.active a {
      background: #6c4eff;
      color: #fff;
      border-radius: 10px;
    }

    .topbar {
      position: fixed;
      top: 0;
      left: 220px;
      width: calc(100% - 220px);
      background: #084D8A;
      color: #fff;
      padding: 0 30px;
      height: 60px;
      display: flex;
      justify-content: flex-end;
      align-items: center;
      z-index: 1000;
    }

    .main-content {
      margin-left: 220px;
      padding: 30px;
      background-color: #e6f0f7;
      min-height: 70vh;
    }

    .dashboard-hero {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: #fff;
      padding: 20px 30px;
      border-radius: 16px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    }

    .hero-left h1 {
      font-size: 32px;
      font-weight: 700;
      color: #2c3e50;
    }

    .dashboard-sections {
      display: flex;
      gap: 20px;
      margin-top: 30px;
      flex-wrap: wrap;
    }

    .left-section, .right-section {
      flex: 1;
      min-width: 300px;
      background: #fff;
      padding: 20px;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .achievement-list, .top-student-card ul, .club-avatars {
      list-style: none;
      padding: 0;
      margin-top: 10px;
    }

    .badge {
      background: #6c4eff;
      color: #fff;
      padding: 4px 8px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
    }

    .achievement-list li, .top-student-card li {
      display: flex;
      justify-content: space-between;
      background: #f9f9f9;
      padding: 8px 12px;
      border-radius: 10px;
      margin-bottom: 10px;
    }

    .club-avatars {
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
    }

    .club-avatars img {
      width: 32px;
      height: 32px;
      border-radius: 50%;
    }

    .event-img {
      width: 32px;
      height: 32px;
      object-fit: cover;
      border-radius: 50%;
      vertical-align: middle;
      margin-right: 8px;
    }

    footer {
      text-align: center;
      padding: 10px;
      background: #e0e0e0;
      font-weight: 500;
    }

    .merit-circle {
      position: relative;
      width: 80px;
      height: 80px;
      margin: 0 auto;
    }

    .merit-text {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      font-weight: bold;
      font-size: 18px;
    }

    .user-info {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .user-info img {
      width: 36px;
      height: 36px;
      border-radius: 50%;
      border: 2px solid white;
      cursor: pointer;
    }

    .user-box {
      display: flex;
      flex-direction: column;
      justify-content: center;
      background-color: white;
      padding: 6px 12px;
      border-radius: 16px;
      font-size: 13px;
      line-height: 1.2;
      color: #0f60b6;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    }

    .view-btn {
      background-color: #6c4eff;
      color: white;
      padding: 6px 12px;
      border-radius: 6px;
      text-decoration: none;
      font-weight: 500;
      transition: background-color 0.3s ease;
    }

    .view-btn:hover {
      background-color: #5941c8;
    }
  </style>
</head>
<body>
<%
  String studentName = (String) session.getAttribute("studentName");
  String studentId = (String) session.getAttribute("studentId");
%>

<div class="sidebar">
  <div class="logo-container"><img src="images/logo unievt.png" alt="Logo" style="width: 160px;"></div>
  <ul class="nav-links">
    <li class="active"><a href="dashboard"><span>Dashboard</span></a></li>
    <li><a href="studentEvents.jsp"><span>Events</span></a></li>
    <li><a href="studentFeedback.jsp"><span>Feedback</span></a></li>
    <li><a href="studentAccount.jsp"><span>Account</span></a></li>
  </ul>
</div>

<div class="topbar" id="topbar">
  <div class="user-info">
    <div class="user-box">
      ${studentName} <br><small>${studentId}</small>
    </div>
    <img src="images/user.jpg" alt="User">
  </div>
</div>

<div class="main-content">
  <div class="dashboard-hero">
    <div class="hero-left">
      <h2>WELCOME</h2>
      <h1>${studentName}</h1>
    </div>
    <div class="hero-right">
      <img src="images/dashboard.png" alt="Banner" style="width: 160px;">
    </div>
  </div>

  <div class="dashboard-sections">
    <!-- LEFT -->
    <div class="left-section">
      <h3>Upcoming Events</h3>
      <c:forEach var="e" items="${inProgressEvents}">
        <div style="margin-bottom: 10px;">
          <img src="${e.logoPath}" alt="Event Logo" class="event-img">
          <span>${e.name}</span>
          <span style="float: right;">
            <c:choose>
              <c:when test="${e.completed}">✅</c:when>
              <c:otherwise>⏳</c:otherwise>
            </c:choose>
          </span>
        </div>
      </c:forEach>

      <h3 style="margin-top: 30px;">Achievements</h3>
      <ul class="achievement-list">
        <c:forEach var="a" items="${achievements}">
          <li>
            <span>${a.title}</span>
            <a href="certificate.jsp?certId=${a.certId}" target="_blank" class="view-btn">View</a>
          </li>
        </c:forEach>
      </ul>
    </div>

    <!-- RIGHT -->
    <div class="right-section">
      <div class="merit-card">
        <h4>Merits</h4>
        <div class="merit-circle">
          <canvas id="meritChart" width="80" height="80"></canvas>
          <div class="merit-text">${meritPercentage}%</div>
        </div>
      </div>

      <div class="top-student-card">
        <h4>Top Student</h4>
        <ul>
          <c:forEach var="s" items="${topStudents}">
            <li><span>${s}</span><span class="badge">97%</span></li>
          </c:forEach>
        </ul>
      </div>

      <div class="club-card">
        <h4>Joined Club</h4>
        <div class="club-avatars">
          <c:forEach var="club" items="${joinedClubs}">
            <img src="${club}" alt="Club Logo">
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
</div>

<footer>
  &copy; Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
</footer>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
  const ctx = document.getElementById('meritChart').getContext('2d');
  new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: ['Completed', 'Remaining'],
      datasets: [{
        data: [${meritPercentage}, 100 - ${meritPercentage}],
        backgroundColor: ['#4caf50', '#e0e0e0'],
        borderWidth: 1
      }]
    },
    options: {
      cutout: '70%',
      plugins: { legend: { display: false } },
      responsive: false
    }
  });
</script>
</body>
</html>
