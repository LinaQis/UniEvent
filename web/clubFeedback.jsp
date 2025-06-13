<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Club Feedback - UniEvent</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="style.css">
  <style>
    /* same CSS styles as you already have... */
  </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">

<!-- Topbar -->
<div class="topbar">
  <div class="topbar-left">
    <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
  </div>
  <div class="topbar-right">
    <span class="club-name">THE SOUND CLUB</span>
    <img src="images/user.png" alt="Profile" class="profile-pic">
  </div>
</div>

<!-- Dashboard Container -->
<div class="dashboard-container">
  <!-- Sidebar -->
  <div class="sidebar">
    <img src="images/logo.png" alt="Logo" class="left-logo">
    <a href="clubDashboard.jsp">Dashboard</a>
    <a href="clubAboutMenu.jsp">About</a>
    <a href="clubFeedback.jsp" class="active">Feedback</a>
    <a href="clubActivity.jsp">Activity</a>
    <a href="clubAccount.jsp">Account</a>
  </div>

  <!-- Content -->
  <div class="content">
    <div class="headerclub">Review and Rating</div>
    <div class="feedback-grid">
      <%
        String clubName = "THE SOUND CLUB";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/UniEventDB", "app", "app");
            String sql = "SELECT * FROM FEEDBACK WHERE UPPER(CLUB_NAME) = ? ORDER BY SUBMISSION_DATE DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, clubName.toUpperCase());
            rs = stmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString("STUDENT_NAME");
                String date = rs.getTimestamp("SUBMISSION_DATE").toString().split(" ")[0];
                int rating = rs.getInt("RATING");
                String event = rs.getString("EVENT_NAME");
                String comment = rs.getString("COMMENTS");
      %>
      <div class="feedback-card">
        <div class="feedback-header">
          <div class="feedback-profile">
            <img src="images/profile1.png" alt="Profile">
            <div>
              <div class="feedback-name"><%= name %> . <%= date %></div>
              <div class="stars">
                <% for (int i = 1; i <= 5; i++) {
                     out.print(i <= rating ? "★" : "☆");
                   }
                %>
              </div>
            </div>
          </div>
          <div class="tag"><%= event %></div>
        </div>
        <p style="margin-top: 10px; font-size: 14px; line-height: 1.5;">
          <%= comment != null ? comment : "No comment." %>
        </p>
      </div>
      <% 
            }
        } catch (Exception e) {
            out.println("<p>Error fetching feedback: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
      %>
    </div>

    <div class="pagination">
      <button>&lt;</button>
      <button class="active">1</button>
      <button>2</button>
      <button>3</button>
      <button>&gt;</button>
    </div>

    <div class="feedbackfooter">
      © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
    </div>
  </div>
</div>
</div>
</body>
</html>
