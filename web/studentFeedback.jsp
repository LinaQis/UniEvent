<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Student Feedback</title>
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
      padding: 20px 50px;
      background-color: #93c2df;
      min-height: calc(100vh - 130px);
      transition: margin-left 0.3s ease;
      margin-bottom: -10px
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

    .feedback-wrapper {
      display: flex;
      justify-content: center;
      align-items: center;
      padding-top: 0px;
    }

    .feedback-card {
      background: #ffffff;
      padding: 20px 30px;
      max-width: 600px;
      width: 100%;
      border-radius: 20px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .feedback-card h2 {
      font-size: 28px;
      margin-bottom: 8px;
    }

    .feedback-card p {
      font-size: 14px;
      color: #666;
      margin-bottom: 24px;
    }

    .feedback-card label {
      display: block;
      margin: 15px 0 6px;
      font-weight: 600;
      text-align: left;
    }

    .feedback-card input[type="text"],
    .feedback-card select,
    .feedback-card textarea {
      width: 100%;
      padding: 10px 14px;
      border-radius: 10px;
      border: 1px solid #ccc;
      font-size: 14px;
    }

    .feedback-card textarea {
      resize: none;
    }

    .button-group {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
      margin-top: 20px;
    }

    .cancel-btn {
      color: #0f60b6;
      font-weight: 500;
      text-decoration: none;
    }

    .submit-btn {
      background-color: #0f60b6;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 10px;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .submit-btn:hover {
      background-color: #094a8f;
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
    <li class="active"><a href="studentFeedback.jsp"><img src="images/fbk.png" alt=""><span>Feedback</span></a></li>
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
  <div>Student Feedback</div>
  <div>Home &gt; <strong>Feedback</strong></div>
</div>
<div class="main-content" id="mainContent">
  <div class="feedback-wrapper">
    <div class="feedback-card">
      <h2>Student Feedback</h2>
      <p>Please help us improve our website by filling out this form.</p>
      <form action="SubmitFeedbackServlet" method="post">
        <label for="club">Club Name</label>
        <input type="text" id="club" name="club" placeholder="Enter club name" required>

        <label for="event">Event Name</label>
        <input type="text" id="event" name="event" placeholder="Enter the event’s name" required>

        <label for="rating">Rating</label>
        <select name="rating" id="rating" required>
          <option value="">Select rating</option>
          <option value="1">★☆☆☆☆</option>
          <option value="2">★★☆☆☆</option>
          <option value="3">★★★☆☆</option>
          <option value="4">★★★★☆</option>
          <option value="5">★★★★★</option>
        </select>

        <label for="comments">Comment</label>
        <textarea name="comments" id="comments" placeholder="Add your comments..." rows="5"></textarea>

        <div class="button-group">
          <a href="#" class="cancel-btn">Cancel</a>
          <button type="submit" class="submit-btn">Submit</button>
        </div>
      </form>
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
