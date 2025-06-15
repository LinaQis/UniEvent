<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- This JSP provides the common sidebar for student-facing pages --%>
<%-- It assumes staffName and username are set in the session for the topbar --%>
<style>
    /* Sidebar specific styles */
    .sidebar {
        width: 220px;
        background-color: #ffffff;
        border-right: 1px solid #e0e0e0;
        padding-top: 20px;
        box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        transition: width 0.3s ease;
        position: fixed;
        height: calc(100vh - 60px); /* Adjust height for topbar */
        top: 60px;
        left: 0;
        z-index: 99;
        overflow-y: auto; /* Enable scrolling for long menus */
    }
    .sidebar.collapsed {
        width: 60px;
    }
    .sidebar a {
        display: block;
        padding: 12px 20px;
        color: #333;
        text-decoration: none;
        font-weight: 500;
        transition: background-color 0.2s ease;
        white-space: nowrap; /* Prevent text wrapping */
        overflow: hidden;
        text-overflow: ellipsis; /* Add ellipsis for overflowed text */
    }
    .sidebar a:hover, .sidebar a.active {
        background-color: #e6e6e6;
        color: #003366;
    }
    .sidebar .left-logo {
        display: block;
        margin: 0 auto 20px auto;
        width: 150px; /* Adjust size as needed */
        transition: width 0.3s ease;
    }
    .sidebar.collapsed .left-logo {
        width: 40px; /* Smaller logo when collapsed */
    }
    .sidebar a span.icon {
        margin-right: 10px; /* Space between icon and text */
        font-size: 18px; /* Adjust icon size */
        display: inline-block; /* Ensure icon doesn't break line */
    }
    .sidebar.collapsed a span.text {
        display: none; /* Hide text when collapsed */
    }
    .sidebar .menu-item {
        display: flex;
        align-items: center;
    }
</style>
<div class="sidebar" id="sidebar">
    <img src="images/logo.png" alt="UniEvent Logo" class="left-logo">
    <a href="student/dashboard" class="menu-item ${currentPage == 'dashboard' ? 'active' : ''}">
        <span class="icon">🏠</span> <span class="text">Dashboard</span>
    </a>
    <a href="student/events" class="menu-item ${currentPage == 'events' ? 'active' : ''}">
        <span class="icon">🎟️</span> <span class="text">Events</span>
    </a>
    <a href="student/clubs" class="menu-item ${currentPage == 'clubs' ? 'active' : ''}">
        <span class="icon">🏆</span> <span class="text">Clubs</span>
    </a>
    <a href="student/merit" class="menu-item ${currentPage == 'merit' ? 'active' : ''}">
        <span class="icon">🏅</span> <span class="text">Merit</span>
    </a>
    <a href="student/achievements" class="menu-item ${currentPage == 'achievements' ? 'active' : ''}">
        <span class="icon">📜</span> <span class="text">Achievements</span>
    </a>
    <a href="student/feedback" class="menu-item ${currentPage == 'feedback' ? 'active' : ''}">
        <span class="icon">💬</span> <span class="text">Feedback</span>
    </a>
    <a href="student/account" class="menu-item ${currentPage == 'account' ? 'active' : ''}">
        <span class="icon">👤</span> <span class="text">Account</span>
    </a>
    <a href="logout.jsp" class="menu-item">
        <span class="icon">🚪</span> <span class="text">Log Out</span>
    </a>
</div>

<script>
    // This script should be outside the immersive block for it to be accessible
    // by other immersives. However, for self-contained JSP, it's fine here.
    // Ensure the toggleSidebar function is defined globally or within a relevant script block
    // that gets executed. For includes, this is usually placed in the main JSP file.
    // For now, I'm providing it assuming it will be merged/called from a main script.
    
    // Function to toggle sidebar (if not already globally defined)
    // This function needs to be available to the menu-toggle button in the topbar.
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const dashboardContainer = document.querySelector('.dashboard-container') || document.body; // Use body as fallback
        const mainContentWrapper = document.getElementById('mainContentWrapper') || document.querySelector('.main-content');
        const topbar = document.getElementById('topbar');
        const subHeader = document.getElementById('subHeader');
        const footer = document.getElementById('page-footer') || document.querySelector('.main-footer');

        sidebar.classList.toggle('collapsed');
        dashboardContainer.classList.toggle('sidebar-collapsed'); // If there's a container that adjusts layout
        
        // Adjust margins of main content, topbar, subheader, footer
        const isCollapsed = sidebar.classList.contains('collapsed');
        const sidebarWidth = isCollapsed ? 60 : 220;
        const calcWidth = `calc(100% - ${sidebarWidth}px)`;

        if (mainContentWrapper) {
            mainContentWrapper.style.marginLeft = `${sidebarWidth}px`;
        }
        if (topbar) {
            topbar.style.left = `${sidebarWidth}px`;
            topbar.style.width = calcWidth;
        }
        if (subHeader) {
            subHeader.style.left = `${sidebarWidth}px`;
            subHeader.style.width = calcWidth;
        }
        if (footer) {
            footer.style.marginLeft = `${sidebarWidth}px`;
            footer.style.width = calcWidth;
        }
    }
</script>
