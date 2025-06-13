<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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
      background-color: #084D8A;
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
    
.dashboard-hero {
  display: flex;
  justify-content: space-between;
  background: #fff;
  border-radius: 16px;
  padding: 20px 30px;
  align-items: center;
  box-shadow: 0 8px 18px rgba(0, 0, 0, 0.08);
}

.hero-left h2 {
  font-size: 20px;
  color: #163567;
}

.hero-left h1 {
  font-size: 36px;
  font-weight: 700;
  color: #2c3e50;
}

.hero-right img {
  width: 180px;
}

.dashboard-panel {
  margin-top: 30px;
  background: #1c2c50;
  border-radius: 20px;
  padding: 30px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
}

.panel-card {
  background: #fff;
  border-radius: 16px;
  padding: 20px;
  text-align: center;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

.stat-card {
  display: flex;
  align-items: center;
  gap: 15px;
  justify-content: center;
}

.achievements-card ul {
  list-style: none;
  padding: 0;
  margin-top: 10px;
}

.achievement-list li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #f8f8f8;
  margin-top: 10px;
  padding: 8px 12px;
  border-radius: 10px;
  font-size: 14px;
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


.card-icon {
  width: 40px;
  height: 40px;
}

.stat h3 {
  font-size: 28px;
  margin: 0;
  color: #333;
}

.stat p {
  margin: 0;
  color: #777;
  font-weight: 500;
}

.top-student-card ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.top-student-card li {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 10px;
}

.student-pic {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  margin-right: 10px;
}

.badge {
  background: #6c4eff;
  color: white;
  padding: 4px 8px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
}

.merit-card .merit-circle {
  position: relative;
  width: 80px;
  height: 80px;
  margin: 10px auto;
}

.merit-text {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-weight: 600;
  font-size: 18px;
}

.club-avatars {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 8px;
}

.club-avatars img {
  width: 30px;
  height: 30px;
  border-radius: 50%;
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
  int inProgress = 3;
  String[] topStudents = {"Mohd Hafidz Zafrel", "Mohd Hana Huzairi", "Nur Qaisya Alyssa"};
  int meritPercentage = 50;
%>

<div class="sidebar" id="sidebar">
  <div class="sidebar-toggle" onclick="toggleSidebar()">
    <img src="images/sideB.png" alt="Toggle">
  </div>
  <div class="logo-container">
    <img src="images/logo unievt.png" alt="Logo" class="logo">
  </div>
  <ul class="nav-links">
    <li class="active"><a href="studentDashboard.jsp"><img src="images/db.png" alt=""><span>Dashboard</span></a></li>
    <li><a href="studentEvents.jsp"><img src="images/evt.png" alt=""><span>Events</span></a></li>
    <li><a href="studentFeedback.jsp"><img src="images/fbk.png" alt=""><span>Feedback</span></a></li>
    <li><a href="studentAccount.jsp"><img src="images/pf.png" alt=""><span>Account</span></a></li>
  </ul>
</div>

<div class="topbar" id="topbar">
  <div class="topbar-inner">
    <div class="user-info">
      <div class="user-box">
        ${studentName}<br><small>${studentId}</small>
      </div>
      <img src="images/user.jpg" alt="User">
    </div>
  </div>
</div>

<div class="sub-header" id="subHeader">
  <div>Student Dashboard</div>
  <div>Home &gt; <strong>Dashboard</strong></div>
</div>

<div class="main-content" id="mainContent">
<div class="dashboard-hero">
  <div class="hero-left">
    <h2>WELCOME</h2>
    <h1>${studentName}</h1>
  </div>
  <div class="hero-right">
    <img src="images/dashboard.png" alt="Dashboard Banner">
  </div>
</div>

<c:forEach var="e" items="${inProgressEvents}">
  <div class="event-entry">
    <img src="${e.logoPath}" alt="Event Logo" />
    <span>${e.name}</span>
    <span class="progress-icon">
      <c:choose>
        <c:when test="${e.completed}">✅</c:when>
        <c:otherwise>⏳</c:otherwise>
      </c:choose>
    </span>
  </div>
</c:forEach>

<div class="panel-card achievements-card">
  <h4>Achievements</h4>
  <ul class="achievement-list">
    <c:forEach var="a" items="${achievements}">
      <li>
        <span>${a.title}</span>
        <a href="certificate.jsp?certId=${a.certId}" target="_blank" class="view-btn">View</a>
      </li>
    </c:forEach>
  </ul>
</div>

<div class="panel-card top-student-card">
  <h4>Top Student</h4>
  <ul>
    <c:forEach var="s" items="${topStudents}">
      <li>
        <img src="images/user.jpg" class="student-pic" alt="">
        <span>${s}</span>
        <span class="badge">97%</span>
      </li>
    </c:forEach>
  </ul>
</div>

<div class="panel-card merit-card">
  <h4>Merits</h4>
  <div class="merit-circle">
    <canvas id="meritChart" width="80" height="80"></canvas>
    <div class="merit-text">${meritPercentage}%</div>
  </div>
</div>

<div class="panel-card club-card">
  <h4>Joined Club</h4>
  <div class="club-avatars">
  <c:forEach var="club" items="${joinedClubs}">
  <img src="${club}" alt="Club Logo">
</c:forEach>

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
