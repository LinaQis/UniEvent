<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* This styling is identical to the other sidebars to maintain consistency */
    .sidebar .nav-links {
        flex-grow: 1; 
        display: flex;
        flex-direction: column;
    }
    .sidebar .logout-link {
        margin-top: auto;
        padding-bottom: 20px;
    }
    .sidebar .logout-link a {
        color: #dc3545;
    }
    .sidebar .logout-link a:hover {
        background-color: #f8d7da;
    }
</style>

<div class="sidebar" id="sidebar">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/images/logo unievt.png" alt="Logo" class="logo" />
    </div>
    <ul class="nav-links">
        <li class="${pageTitle == 'Club Dashboard' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/club/dashboard">
                <img src="${pageContext.request.contextPath}/images/dashboard-icon.png" alt="Dashboard" />
                <span>Dashboard</span>
            </a>
        </li>
        <li class="${pageTitle == 'My Activities' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/club/activities">
                <img src="${pageContext.request.contextPath}/images/event-icon.png" alt="Activities" />
                <span>Activities</span>
            </a>
        </li>
        <li class="${pageTitle == 'Propose New Activity' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/club/activityProposal">
                <img src="${pageContext.request.contextPath}/images/proposal-icon.png" alt="Propose Activity" />
                <span>Propose Activity</span>
            </a>
        </li>
        <li class="${pageTitle == 'Club Members' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/club/members">
                <img src="${pageContext.request.contextPath}/images/members-icon.png" alt="Members" />
                <span>Members</span>
            </a>
        </li>
        <li class="${pageTitle == 'Club Feedback' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/club/feedback">
                <img src="${pageContext.request.contextPath}/images/feedback-icon.png" alt="Feedback" />
                <span>Feedback</span>
            </a>
        </li>
        <li class="${pageTitle == 'About Club' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/club/about">
                <img src="${pageContext.request.contextPath}/images/info-icon.png" alt="About Club" />
                <span>About Club</span>
            </a>
        </li>
        <li class="${pageTitle == 'Past Events' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/club/pastEvents">
                <img src="${pageContext.request.contextPath}/images/history-icon.png" alt="Past Events" />
                <span>Past Events</span>
            </a>
        </li>
        <li class="${pageTitle == 'Club Account' ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/club/account">
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
