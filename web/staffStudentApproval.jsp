<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Student" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Approval - UniEvent</title>
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

        /* Student Approval Specific Styles */
        .header-section {
            background-color: #fcd94c;
            padding: 15px 20px;
            border-radius: 8px;
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
        }

        .student-approval-container {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .student-list-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .student-list-table th, .student-list-table td {
            text-align: left;
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            font-size: 15px;
        }
        .student-list-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #555;
            text-transform: uppercase;
        }
        .student-list-table tbody tr:hover {
            background-color: #f0f8ff;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        .action-buttons button {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.2s ease;
        }
        .approve-btn {
            background-color: #32d183; /* Green */
            color: white;
        }
        .approve-btn:hover {
            background-color: #2ab870;
        }
        .reject-btn {
            background-color: #f14c4c; /* Red */
            color: white;
        }
        .reject-btn:hover {
            background-color: #d63d3d;
        }

        /* Popup messages for success/error */
        .popup {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 6px;
            font-weight: 600;
            z-index: 9999;
            display: none; /* Hidden by default */
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .popup.success { background-color: #32d183; color: white; }
        .popup.error { background-color: #f14c4c; color: white; }

        /* Responsive adjustments */
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
            .student-approval-container {
                padding: 15px;
            }
            .student-list-table th, .student-list-table td {
                padding: 8px 10px;
                font-size: 13px;
            }
            .action-buttons {
                flex-direction: column;
                gap: 5px;
            }
            .action-buttons button {
                width: 100%;
            }
        }
    </style>
</head>
<body class="dashboard-page">
    <%
        String staffName = (String) session.getAttribute("staffName");
        String staffId = (String) session.getAttribute("username"); // Assuming staffId is username
        if (staffName == null) staffName = "Staff";
        if (staffId == null) staffId = "N/A";
    %>

    <div class="staff-student-approval">
        <!-- Topbar -->
        <div class="topbar" id="topbar">
            <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
            <div class="topbar-left">Student Approval</div>
            <div class="topbar-right">
                <%= staffName.toUpperCase() %>
                <img src="images/user.png" alt="Profile" class="profile-pic">
            </div>
        </div>

        <!-- Dashboard Container -->
        <div class="dashboard-container" id="dashboardContainer">
            <!-- Sidebar -->
            <div class="sidebar" id="sidebar">
                <img src="images/logo.png" alt="Logo" class="left-logo">
                <a href="staff/dashboard">Dashboard</a>
                <a href="staff/activities">Activities</a>
                <a href="staff/studentApproval" class="active">Student Approval</a>
                <a href="staff/reports">Reports</a>
                <a href="staff/feedback">Feedback</a>
                <a href="staff/account">Account</a>
                <a href="logout.jsp">Log Out</a>
            </div>

            <!-- Main Content -->
            <div class="main-content-wrapper" id="mainContentWrapper">
                <div class="header-section">Pending Student Registrations</div>

                <div class="student-approval-container">
                    <table class="student-list-table">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Student Name</th>
                                <th>Student ID</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pendingStudents}">
                                    <c:forEach var="student" items="${pendingStudents}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${student.student_name}</td>
                                            <td>${student.student_no}</td>
                                            <td>${student.student_email}</td> <%-- Assuming getStudent_email() exists --%>
                                            <td>Pending</td>
                                            <td>
                                                <div class="action-buttons">
                                                    <form action="StaffManagementServlet" method="post" style="display: inline;">
                                                        <input type="hidden" name="action" value="approveStudent">
                                                        <input type="hidden" name="student_id" value="${student.student_no}">
                                                        <button type="submit" class="approve-btn">Approve</button>
                                                    </form>
                                                    <form action="StaffManagementServlet" method="post" style="display: inline;">
                                                        <input type="hidden" name="action" value="rejectStudent">
                                                        <input type="hidden" name="student_id" value="${student.student_no}">
                                                        <button type="submit" class="reject-btn">Reject</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6">No pending student registrations.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Footer -->
            <div class="main-footer">
                © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
            </div>
        </div>
    </div>

    <div id="popupMessage" class="popup"></div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
            document.getElementById('dashboardContainer').classList.toggle('sidebar-collapsed');
            document.getElementById('mainContentWrapper').classList.toggle('collapsed-main');
        }

        // Adjust content margins when sidebar is collapsed/expanded
        document.addEventListener('DOMContentLoaded', () => {
            const sidebar = document.getElementById('sidebar');
            const mainContentWrapper = document.getElementById('mainContentWrapper');
            const topbar = document.getElementById('topbar');
            const subHeader = document.getElementById('subHeader');
            const footer = document.querySelector('.main-footer');

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

            adjustLayout();
            document.querySelector('.menu-toggle').addEventListener('click', adjustLayout);

            // Popup message display logic
            const params = new URLSearchParams(window.location.search);
            const popup = document.getElementById("popupMessage");
            if (params.get("approval") === "success") {
                popup.textContent = "Student approval status updated successfully!";
                popup.className = "popup success";
                popup.style.display = "block";
            } else if (params.get("approval") === "error") {
                popup.textContent = "There was an error updating student approval status.";
                popup.className = "popup error";
                popup.style.display = "block";
            }
            if (params.has("approval")) {
                const url = new URL(window.location.href);
                url.searchParams.delete("approval");
                window.history.replaceState({}, document.title, url.toString());
            }
            setTimeout(() => popup.style.display = "none", 4000);
        });
    </script>
</body>
</html>
