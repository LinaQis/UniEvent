<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Club" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Clubs - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        /* General body styling */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: #f4f6f9;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        /* Topbar styling */
        .topbar {
            background-color: #0f60b6;
            color: white;
            padding: 0 30px;
            height: 60px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            position: fixed;
            top: 0;
            left: 220px; /* Aligned with sidebar width */
            width: calc(100% - 220px);
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
            width: 100%;
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
        /* Sub-header styling */
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
            position: fixed;
            top: 60px;
            left: 220px;
            width: calc(100% - 220px);
            transition: margin-left 0.3s ease;
        }
        .sidebar.collapsed ~ .sub-header {
            margin-left: 60px;
        }
        /* Main content area styling */
        .main-content-wrapper {
            margin-left: 220px;
            padding: 100px 50px 50px;
            background-color: #f4f6f9;
            flex: 1;
            transition: margin-left 0.3s ease;
        }
        .sidebar.collapsed ~ .main-content-wrapper {
            margin-left: 60px;
        }
        /* Footer styling - will be replaced by studentFooter.jsp styles */
        .main-footer {
            margin-left: 220px;
            text-align: center;
            padding: 12px;
            background-color: #e0e0e0;
            color: #111;
            font-size: 14px;
            font-weight: 500;
            transition: margin-left 0.3s ease;
            position: relative;
            width: calc(100% - 220px);
            box-sizing: border-box;
        }
        .sidebar.collapsed ~ .main-footer {
            margin-left: 60px;
            width: calc(100% - 60px);
        }

        /* Club listing specific styles */
        .header-section {
            background-color: #fcd94c;
            padding: 15px 20px;
            border-radius: 8px;
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }
        .category-filter {
            margin-bottom: 20px;
            text-align: center;
        }
        .category-filter button {
            background-color: #e0e0e0;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            margin: 5px;
            cursor: pointer;
            font-weight: 600;
            color: #555;
            transition: background-color 0.2s ease, color 0.2s ease;
        }
        .category-filter button.active, .category-filter button:hover {
            background-color: #0f60b6;
            color: white;
        }
        .club-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            padding-bottom: 20px;
        }
        .club-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
            text-align: center;
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease;
        }
        .club-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        }
        .club-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
        }
        .club-card-content {
            padding: 15px;
            flex-grow: 1; /* Allow content to take available space */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .club-card-content h3 {
            font-size: 20px;
            margin-top: 0;
            margin-bottom: 10px;
            color: #003366;
        }
        .club-card-content p {
            font-size: 14px;
            color: #666;
            line-height: 1.5;
            margin-bottom: 15px;
            flex-grow: 1; /* Allow description to grow */
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3; /* Limit description to 3 lines */
            -webkit-box-orient: vertical;
        }
        .view-club-btn {
            background-color: #4285f4;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            display: block; /* Make button full width */
            width: calc(100% - 30px); /* Account for padding */
            margin: 0 auto;
            transition: background-color 0.2s ease;
        }
        .view-club-btn:hover {
            background-color: #3a75e0;
        }

        /* Responsive adjustments for main layout */
        @media (max-width: 768px) {
            .topbar {
                left: 0;
                width: 100%;
            }
            .sidebar {
                width: 0;
                overflow: hidden;
            }
            .sidebar.collapsed {
                width: 60px;
            }
            .sidebar.expanded {
                width: 220px;
            }
            .main-content-wrapper {
                margin-left: 0;
                padding: 120px 20px 80px;
            }
            .main-footer {
                margin-left: 0;
                width: 100%;
            }
            .club-grid {
                grid-template-columns: 1fr; /* Single column on small screens */
            }
        }
    </style>
</head>
<body class="dashboard-page">
    <%
        String studentName = (String) session.getAttribute("studentName");
        String studentId = (String) session.getAttribute("username"); // Assuming studentId is username
        if (studentName == null) studentName = "Student";
        if (studentId == null) studentId = "N/A";
        
        List<Club> allClubs = (List<Club>) request.getAttribute("clubs");
        // Get unique categories for filter buttons
        java.util.Set<String> categories = new java.util.HashSet<>();
        if (allClubs != null) {
            for (Club c : allClubs) {
                categories.add(c.getClub_category()); // Assuming Club model has getClub_category()
            }
        }
    %>

    <jsp:include page="studentSidebar.jsp">
        <jsp:param name="currentPage" value="clubs" />
    </jsp:include>

    <div class="topbar" id="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-inner">
            <div class="user-info">
                <div class="user-box">
                    <%= studentName %><br><small><%= studentId %></small>
                </div>
                <img src="images/user.jpg" alt="User" class="profile-pic">
            </div>
        </div>
    </div>

    <div class="sub-header" id="subHeader">
        <div>Clubs</div>
        <div>Home &gt; <strong>Clubs</strong></div>
    </div>

    <div class="main-content-wrapper" id="mainContentWrapper">
        <div class="header-section">All Clubs</div>

        <div class="category-filter">
            <button class="filter-btn active" data-category="all">All</button>
            <c:forEach var="category" items="<%= categories %>">
                <button class="filter-btn" data-category="${category.toLowerCase()}">${category}</button>
            </c:forEach>
        </div>

        <div class="club-grid" id="clubGrid">
            <c:choose>
                <c:when test="${not empty clubs}">
                    <c:forEach var="club" items="${clubs}">
                        <div class="club-card" data-category="${club.club_category.toLowerCase()}">
                            <img src="${club.logo_path != null && not empty club.logo_path ? club.logo_path : 'images/default_club_logo.png'}" 
                                 alt="${club.club_name} Logo">
                            <div class="club-card-content">
                                <h3>${club.club_name}</h3>
                                <p>${club.club_desc}</p>
                                <a href="student/clubDetails?club_id=${club.club_id}" class="view-club-btn">View Details</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>No clubs available at this time.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="studentFooter.jsp" />

    <script>
        // Adjust content margins when sidebar is collapsed/expanded
        document.addEventListener('DOMContentLoaded', () => {
            const sidebar = document.getElementById('sidebar');
            const mainContentWrapper = document.getElementById('mainContentWrapper');
            const topbar = document.getElementById('topbar');
            const subHeader = document.getElementById('subHeader');
            const footer = document.getElementById('page-footer');

            const adjustLayout = () => {
                const isCollapsed = sidebar.classList.contains('collapsed');
                const sidebarWidth = isCollapsed ? 60 : 220;
                const calcWidth = `calc(100% - ${sidebarWidth}px)`;

                mainContentWrapper.style.marginLeft = `${sidebarWidth}px`;
                topbar.style.left = `${sidebarWidth}px`;
                topbar.style.width = calcWidth;
                if (subHeader) {
                    subHeader.style.left = `${sidebarWidth}px`;
                    subHeader.style.width = calcWidth;
                }
                if (footer) {
                    footer.style.marginLeft = `${sidebarWidth}px`;
                    footer.style.width = calcWidth;
                }
            };

            adjustLayout(); // Initial adjustment
            // The toggleSidebar function is now in studentSidebar.jsp and needs to be called
            // from the main page if the menu-toggle button is in the topbar of the main page.
            // If the button is part of the included sidebar, this is fine.
            // Assuming the `toggleSidebar` function is globally accessible.
            document.querySelector('.menu-toggle').addEventListener('click', () => {
                 // The toggleSidebar function is defined in studentSidebar.jsp and handles the layout adjustments
                 toggleSidebar();
            });


            // Club Category Filter Logic
            const filterButtons = document.querySelectorAll('.filter-btn');
            const clubCards = document.querySelectorAll('.club-card');

            filterButtons.forEach(button => {
                button.addEventListener('click', () => {
                    // Remove 'active' from all buttons
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    // Add 'active' to the clicked button
                    button.classList.add('active');

                    const selectedCategory = button.dataset.category;

                    clubCards.forEach(card => {
                        const cardCategory = card.dataset.category;
                        if (selectedCategory === 'all' || selectedCategory === cardCategory) {
                            card.style.display = 'flex'; // Show card
                        } else {
                            card.style.display = 'none'; // Hide card
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>
