<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Members - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        .status-active {
            background-color: #32d183;
            color: white;
            padding: 4px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-inactive {
            background-color: #f14c4c;
            color: white;
            padding: 4px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
        }

        .member-table th, .member-table td {
            padding: 12px;
            text-align: left;
        }

        .member-table {
            width: 100%;
            border-collapse: collapse;
        }

        .member-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .top-summary {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .summary-box {
            background-color: #f0f8ff;
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            width: 150px;
        }

        .pagination {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            color: #555;
        }
    </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">

    <!-- Topbar -->
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Club Members</div>
        <div class="topbar-right">Home &gt; Events</div>
    </div>

    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <img src="images/logo.png" class="left-logo" alt="Logo">
            <a href="#">Dashboard</a>
            <a href="#" class="active">About</a>
            <a href="#">Feedback</a>
            <a href="#">Activity</a>
            <a href="#">Account</a>
        </div>

        <!-- Main Content -->
        <div class="main">
            <div class="headerclub">All Members</div>

            <!-- Summary Row -->
            <div class="top-summary">
                <div class="summary-box">
                    <div style="font-size: 24px; font-weight: bold;">70</div>
                    <div>Total members</div>
                </div>
                <div class="summary-box">
                    <div style="font-size: 24px; font-weight: bold;">10</div>
                    <div>Active Now</div>
                </div>
                <div>
                    <input type="text" placeholder="Search" style="padding: 10px; border-radius: 8px; border: 1px solid #ccc;">
                </div>
            </div>

            <!-- Table -->
            <table class="member-table">
                <thead>
                    <tr style="background-color: #e8f0fe;">
                        <th>Student Name</th>
                        <th>Student ID</th>
                        <th>Phone Number</th>
                        <th>Email</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Adlina Balqis</td>
                        <td>2023657196</td>
                        <td>0179794635</td>
                        <td>2023657196@student.uitm.edu.my</td>
                        <td><span class="status-active">Active</span></td>
                    </tr>
                    <tr>
                        <td>Siti Nuraina</td>
                        <td>2024204526</td>
                        <td>01118810602</td>
                        <td>2024204526@student.uitm.edu.my</td>
                        <td><span class="status-inactive">Inactive</span></td>
                    </tr>
                    <tr>
                        <td>Muhammad Raziq</td>
                        <td>202455555</td>
                        <td>0123456678</td>
                        <td>202455555@student.uitm.edu.my</td>
                        <td><span class="status-inactive">Inactive</span></td>
                    </tr>
                    <tr>
                        <td>Muhamad Fahmi</td>
                        <td>202444444</td>
                        <td>0124576890</td>
                        <td>202444444@student.uitm.edu.my</td>
                        <td><span class="status-active">Active</span></td>
                    </tr>
                    <tr>
                        <td>Jauza Kamilia</td>
                        <td>202400000</td>
                        <td>0198422367</td>
                        <td>202400000@student.uitm.edu.my</td>
                        <td><span class="status-active">Active</span></td>
                    </tr>
                    <tr>
                        <td>Ahmad Farish</td>
                        <td>202488888</td>
                        <td>0145567822</td>
                        <td>202488888@student.uitm.edu.my</td>
                        <td><span class="status-active">Active</span></td>
                    </tr>
                    <tr>
                        <td>Adam Hakimi</td>
                        <td>202409090</td>
                        <td>0132327880</td>
                        <td>202409090@student.uitm.edu.my</td>
                        <td><span class="status-active">Active</span></td>
                    </tr>
                    <tr>
                        <td>Zahwa Faqihah</td>
                        <td>202456657</td>
                        <td>0145566001</td>
                        <td>202456657@student.uitm.edu.my</td>
                        <td><span class="status-inactive">Inactive</span></td>
                    </tr>
                </tbody>
            </table>

            <!-- Pagination -->
            <div class="pagination">
                <div>Showing data 1 to 8 of 70 members</div>
                <div>
                    <button>&lt;</button>
                    <button style="background-color: #6C63FF; color: white; padding: 6px 12px; border-radius: 5px;">1</button>
                    <button>2</button>
                    <button>3</button>
                    <button>&gt;</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
    </div>
</div>

<script>
    function toggleSidebar() {
        document.querySelector('.sidebar').classList.toggle('collapsed');
        document.querySelector('.dashboard-container').classList.toggle('sidebar-collapsed');
    }
</script>
</body>
</html>
