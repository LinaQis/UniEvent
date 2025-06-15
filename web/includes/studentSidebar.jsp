<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* Shared styles for all sidebars */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 220px;
        height: 100vh;
        background: #fff;
        border-right: 1px solid #e0e0e0;
        z-index: 1000;
        padding-top: 20px;
        transition: width 0.3s ease;
        display: flex;
        flex-direction: column;
    }
    .sidebar .logo-container {
        text-align: center;
        margin-bottom: 20px;
        padding: 0 10px;
    }
    .sidebar .logo {
        width: 160px;
        transition: width 0.3s ease;
    }
    .sidebar .nav-links {
        list-style: none;
        padding: 0;
        margin: 0;
        flex-grow: 1; /* Allows the list to take up available space */
        display: flex;
        flex-direction: column;
    }
    .sidebar .nav-links a {
        display: flex;
        align-items: center;
        padding: 14px 20px;
        text-decoration: none;
        color: #6b7280;
        font-weight: 500;
        transition: background 0.2s, color 0.2s;
        white-space: nowrap;
        overflow: hidden;
    }
    .sidebar .nav-links a:hover {
        background-color: #f0f0f0;
        color: #0f60b6;
    }
    .sidebar .nav-links li.active a {
        background-color: #6c4eff;
        color: #ffffff;
        border-radius: 8px;
        margin: 0 10px;
    }
    .sidebar .nav-links img {
        width: 20px;
        height: 20px;
        margin-right: 15px;
        flex-shrink: 0;
    }
    /* Pushes the logout link to the very bottom of the sidebar */
    .sidebar .logout-link {
        margin-top: auto;
        padding-bottom: 20px;
    }
    /* Style for the logout link */
    .sidebar .logout-link a {
        color: #dc3545;
    }
    .sidebar .logout-link a:hover {
        background-color: #f8d7da;
    }
</style>

<div class="sidebar" id="sidebar">
  <div class="logo-container">
      <img src="${pageContext.request.contextPath}/images/logo unievt.png" alt="Logo" class="logo">
  </div>
  <ul class="nav-links">
    <%-- The 'pageTitle' attribute is set in the parent JSP to highlight the active link --%>
    <li class="${pageTitle == 'Dashboard' ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/student/dashboard">
            <img src="${pageContext.request.contextPath}/images/db.png" alt="Dashboard Icon">
            <span>Dashboard</span>
        </a>
    </li>
    <li class="${pageTitle == 'Events' ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/student/events">
            <img src="${pageContext.request.contextPath}/images/evt.png" alt="Events Icon">
            <span>Events</span>
        </a>
    </li>
     <li class="${pageTitle == 'Clubs' ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/student/clubs">
            <img src="${pageContext.request.contextPath}/images/club-icon.png" alt="Clubs Icon">
            <span>Clubs</span>
        </a>
    </li>
    <li class="${pageTitle == 'Feedback' ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/student/feedback">
            <img src="${pageContext.request.contextPath}/images/fbk.png" alt="Feedback Icon">
            <span>Feedback</span>
        </a>
    </li>
     <li class="${pageTitle == 'Achievements' ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/student/achievements">
            <img src="${pageContext.request.contextPath}/images/achievement-icon.png" alt="Achievements Icon">
            <span>Achievements</span>
        </a>
    </li>
     <li class="${pageTitle == 'Merit' ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/student/merit">
            <img src="${pageContext.request.contextPath}/images/merit-icon.png" alt="Merit Icon">
            <span>Merit</span>
        </a>
    </li>
    <li class="${pageTitle == 'Account' ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/student/account">
            <img src="${pageContext.request.contextPath}/images/pf.png" alt="Account Icon">
            <span>Account</span>
        </a>
    </li>
    
    <!-- === NEW LOGOUT LINK === -->
    <li class="logout-link">
         <a href="${pageContext.request.contextPath}/logout.jsp">
             <img src="${pageContext.request.contextPath}/images/logout-icon.png" alt="Logout" />
             <span>Logout</span>
         </a>
     </li>
  </ul>
</div>
