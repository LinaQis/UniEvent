<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Student Account</title>
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
    <%--account--%>
    .main-content {
      margin-left: 220px;
      padding: 150px 50px 100px;
      background-color: #93c2df;
      min-height: calc(100vh - 130px);
      transition: margin-left 0.3s ease;
    }
    
    .account-card {
  background: #fff;
  padding: 30px;
  border-radius: 16px;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
  max-width: 960px;
  margin: 0 auto;
}

.account-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

.profile-pic {
  width: 72px;
  height: 72px;
  border-radius: 50%;
  object-fit: cover;
  margin-right: 20px;
}

.account-header h3 {
  font-size: 22px;
  margin-bottom: 4px;
}

.account-header p {
  font-size: 14px;
  color: #888;
}

.edit-btn {
  background-color: #0f60b6;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 8px;
  font-weight: bold;
  cursor: pointer;
}

.account-form {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.form-group {
  flex: 1 1 45%;
  display: flex;
  flex-direction: column;
}

.form-group.full {
  flex: 1 1 100%;
}

.form-group label {
  font-weight: 600;
  margin-bottom: 6px;
}

.form-group input {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 10px;
  font-size: 14px;
}

.email-box {
  display: flex;
  align-items: center;
  gap: 10px;
  background: #f4f4f4;
  padding: 10px;
  border-radius: 10px;
  font-size: 14px;
}

.email-status {
  margin-left: auto;
  color: #888;
}

.merit-section {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-top: 10px;
}

.merit-box {
  font-size: 32px;
  font-weight: bold;
  background: #f0f0f0;
  padding: 20px;
  border-radius: 10px;
}

.merit-legend {
  font-size: 12px;
  display: flex;
  flex-direction: column;
  gap: 4px;
  margin-top: 8px;
}

.dot {
  display: inline-block;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-right: 6px;
}

.dot.academic {
  background: #6c4eff;
}
.dot.social {
  background: #4da6ff;
}
.dot.physical {
  background: #f7a9a8;
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
    <li><a href="studentEvents.jsp"><img src="images/evt.png" alt=""><span>Events</span></a></li>
    <li><a href="studentFeedback.jsp"><img src="images/fbk.png" alt=""><span>Feedback</span></a></li>
    <li  class="active"><a href="studentAccount.jsp"><img src="images/pf.png" alt=""><span>Account</span></a></li>
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
  <div>Student Account</div>
  <div>Home &gt; <strong>Account</strong></div>
</div>

<div class="main-content" id="mainContent">
 <div class="account-card">
  <div class="account-header">
    <img src="images/user.jpg" alt="Profile Picture" class="profile-pic">
    <div>
      <h3><%= studentName %></h3>
      <p><%= studentId %></p>
    </div>
    <button class="edit-btn">Edit</button>
  </div>

  <div class="account-form">
    <div class="form-group">
      <label>Full Name</label>
      <input type="text" placeholder="Your First Name">
    </div>
    <div class="form-group">
      <label>Student No.</label>
      <input type="text" placeholder="Your Student No.">
    </div>
    <div class="form-group">
      <label>Phone Number</label>
      <input type="text" placeholder="Your Phone Number">
    </div>
    <div class="form-group">
      <label>Course</label>
      <input type="text" placeholder="Your Course">
    </div>
    <div class="form-group full">
      <label>My email Address</label>
      <div class="email-box">
        <img src="images/email.png" alt="email" style="width:18px;">
        <span>2023657196@student.uitm.edu.my</span>
        <span class="email-status">1 month ago</span>
      </div>
    </div>
    <div class="form-group full">
      <label>Total Merit Points:</label>
      <div class="merit-section">
        <div class="merit-box">120</div>
        <div class="merit-chart">
          <canvas id="meritChart" width="100" height="100"></canvas>
          <div class="merit-legend">
            <span><span class="dot academic"></span>Academic 40%</span>
            <span><span class="dot social"></span>Social 32%</span>
            <span><span class="dot physical"></span>Physical 28%</span>
          </div>
        </div>
      </div>
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
      labels: ['Academic', 'Social activity', 'Physical'],
      datasets: [{
        data: [40, 32, 28],
        backgroundColor: ['#6c4eff', '#4da6ff', '#f7a9a8'],
        borderWidth: 1
      }]
    },
    options: {
      cutout: '70%',
      plugins: { legend: { display: false } }
    }
  });
</script>

</body>
</html>
