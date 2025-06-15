<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Club Gallery - UniEvent</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter&display=swap">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"> <%-- Link to external CSS --%>
    <style>
        /* Specific styles for this page only, or overrides */
        .gallery-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
        }

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .gallery-item {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
            background-color: #f9f9f9;
        }

        .gallery-item:hover {
            transform: translateY(-5px);
        }

        .gallery-item img {
            width: 100%;
            height: 200px; /* Fixed height for consistent grid */
            object-fit: cover; /* Cover the area, cropping if necessary */
            display: block;
        }

        .gallery-item-info {
            padding: 15px;
            text-align: center;
        }

        .gallery-item-info h3 {
            font-size: 1.1em;
            color: #333;
            margin-bottom: 5px;
        }

        .gallery-item-info p {
            font-size: 0.9em;
            color: #777;
        }

        .no-images-message {
            text-align: center;
            padding: 30px;
            color: #777;
            font-style: italic;
        }
    </style>
</head>
<body>
    <%-- Set currentPage for sidebar active state and pageTitle for topbar --%>
    <c:set var="currentPage" value="about" scope="request"/> <%-- Assuming gallery is part of "About Club" section --%>
    <c:set var="pageTitle" value="Club Gallery" scope="request"/>

    <%-- Club Organizer Sidebar (from Part 1) --%>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/unilogo.png" alt="Logo" />
            <span>UniEvent</span>
        </div>
        <ul class="menu">
            <li>
                <a href="${pageContext.request.contextPath}/club/dashboard" class="menu-item ${currentPage == 'dashboard' ? 'active' : ''}">
                    <img src="${pageContext.request.contextPath}/images/dashboard-icon.png" alt="Dashboard" />
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/club/activities" class="menu-item ${currentPage == 'activities' ? 'active' : ''}">
                    <img src="${pageContext.request.contextPath}/images/event-icon.png" alt="Activities" />
                    <span>Activities</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/club/activityProposal" class="menu-item ${currentPage == 'activityProposal' ? 'active' : ''}">
                    <img src="${pageContext.request.contextPath}/images/proposal-icon.png" alt="Propose Activity" />
                    <span>Propose Activity</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/club/members" class="menu-item ${currentPage == 'members' ? 'active' : ''}">
                    <img src="${pageContext.request.contextPath}/images/members-icon.png" alt="Members" />
                    <span>Members</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/club/feedback" class="menu-item ${currentPage == 'feedback' ? 'active' : ''}">
                    <img src="${pageContext.request.contextPath}/images/feedback-icon.png" alt="Feedback" />
                    <span>Feedback</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/club/about" class="menu-item ${currentPage == 'about' ? 'active' : ''}">
                    <img src="${pageContext.request.contextPath}/images/info-icon.png" alt="About Club" />
                    <span>About Club</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/club/pastEvents" class="menu-item ${currentPage == 'pastEvents' ? 'active' : ''}">
                    <img src="${pageContext.request.contextPath}/images/history-icon.png" alt="Past Events" />
                    <span>Past Events</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/club/account" class="menu-item ${currentPage == 'account' ? 'active' : ''}">
                    <img src="${pageContext.request.contextPath}/images/account-icon.png" alt="Account" />
                    <span>Account</span>
                </a>
            </li>
        </ul>
    </div>
    <%-- End Club Organizer Sidebar HTML Block --%>

    <div class="main-content">
        <%-- Student Top Bar HTML Block (used as generic topbar for all roles) --%>
        <div class="topbar">
            <div class="topbar-left">
                <button class="toggle-sidebar" onclick="toggleSidebar()">
                    <img src="${pageContext.request.contextPath}/images/menu-icon.png" alt="Menu" class="h-6 w-6"/>
                </button>
                <span class="page-title">
                    <c:choose>
                        <c:when test="${not empty pageTitle}">${pageTitle}</c:when>
                        <c:otherwise>Dashboard</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="topbar-right">
                <span class="user-name">Hello, <c:out value="${sessionScope.clubName}" default="Club Organizer"/></span>
                <a href="${pageContext.request.contextPath}/logout.jsp" class="logout-btn">
                    <img src="${pageContext.request.contextPath}/images/logout-icon.png" alt="Logout" class="h-5 w-5"/>
                </a>
            </div>
        </div>
        <%-- End Student Top Bar HTML Block --%>

        <div class="content-header">
            <h1><c:out value="${sessionScope.clubName}" default="Your Club"/> Gallery</h1>
        </div>

        <div class="gallery-container">
            <div class="gallery-grid">
                <c:choose>
                    <c:when test="${not empty requestScope.galleryImages}">
                        <c:forEach var="imagePath" items="${requestScope.galleryImages}">
                            <div class="gallery-item">
                                <img src="${pageContext.request.contextPath}/${imagePath}" alt="Gallery Image" onerror="this.onerror=null;this.src='https://placehold.co/280x200/cccccc/333333?text=No+Image';"/>
                                <%-- Optional: Add title/description if you store them in your DB --%>
                                <div class="gallery-item-info">
                                    <h3>Image Title</h3>
                                    <p>Description of the image.</p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="no-images-message">No images available in the gallery yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- Common Footer (from Part 1) --%>
        <footer class="main-footer">
            <p>&copy; 2025 UniEvent. All rights reserved.</p>
        </footer>
        <%-- End Common Footer HTML Block --%>
    </div>
    <script>
        // Common sidebar toggle function (if not already in an external JS file)
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            const mainContent = document.querySelector('.main-content');
            if (sidebar) {
                sidebar.classList.toggle('collapsed');
            }
            if (mainContent) {
                mainContent.classList.toggle('expanded');
            }
        }
    </script>
</body>
</html>
