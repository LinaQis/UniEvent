<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
    This is the updated sidebar for the Staff section.
    The key changes are:
    1. A "Logout" link has been added at the end of the navigation list.
    2. A <style> block has been included to push the logout link to the bottom,
       making the UI more intuitive and clean.
--%>

<style>
    /* Ensures the navigation links container takes up the full available height */
    .sidebar .nav-links {
        flex-grow: 1; 
        display: flex;
        flex-direction: column;
    }

    /* Pushes the logout link to the very bottom of the sidebar */
    .sidebar .logout-link {
        margin-top: auto; /* This is the magic property */
        padding-bottom: 20px; /* Adds some space from the bottom edge */
    }

    /* Style for the logout link to make it stand out slightly */
    .sidebar .logout-link a {
        color: #dc3545; /* A reddish color to indicate a "destructive" action */
    }
    
    .sidebar .logout-link a:hover {
        background-color: #f8d7da; /* Light red background on hover */
    }
</style>

<div class="sidebar" id="sidebar">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/images/logo unievt.png" alt="Logo" class="logo">
    </div>
    <ul class="nav-links">
        <li class="${pageTitle == 'Staff Dashboard' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/dashboard">
                <img src="${pageContext.request.contextPath}/images/dashboard-icon.png" alt="Dashboard" />
                <span>Dashboard</span>
            </a>
        </li>
        <li class="${pageTitle == 'Activities' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/activities">
                <img src="${pageContext.request.contextPath}/images/event-icon.png" alt="Activities" />
                <span>Activities</span>
            </a>
        </li>
        <li class="${pageTitle == 'Reports' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/reports">
                <img src="${pageContext.request.contextPath}/images/report-icon.png" alt="Reports" />
                <span>Reports</span>
            </a>
        </li>
        <li class="${pageTitle == 'Feedback' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/feedback">
                <img src="${pageContext.request.contextPath}/images/feedback-icon.png" alt="Feedback" />
                <span>Feedback</span>
            </a>
        </li>
        <li class="${pageTitle == 'Staff Account' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/staff/account">
                <img src="${pageContext.request.contextPath}/images/account-icon.png" alt="Account" />
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