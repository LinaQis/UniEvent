<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Dashboard - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
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
            <img src="images/logo.png" alt="Logo" class="img">
            <a href="clubDashboard.jsp">Dashboard</a>
            <a href="clubAboutMenu.jsp">About</a>
            <a href="clubFeedback.jsp">Feedback</a>
            <a href="clubActivity.jsp">Activity</a>
            <a href="clubAccount.jsp">Account</a>
        </div>

        <!-- Main Content -->
        <div class="main">
            <div class="main-content-wrapper">
            <div class="headerclub">Club Dashboard</div>
            <!-- Two Column Layout -->
            <div class="dashboard-columns">
                <!-- Left: Welcome & New Members -->
                <div class="left-column">
                    <div class="welcome-box small">
                        <h3>Welcome to Management</h3>
                        <p>Hi, Team Members</p>
                        <p>Project activity will be updated here. Click on the name section to set your configuration.</p>
                    </div>

                    <div class="members-list">
                        <h4>New Members</h4>

                        <div class="member-item">
                            <div class="member-info">
                                <img src="images/profile1.png" alt="Profile">
                                <div>
                                    <div class="member-name">Aminah Awang</div>
                                    <div class="member-id">2025667799</div>
                                </div>
                            </div>
                            <div class="actions">
                                <button class="approve">Approve</button>
                                <button class="reject">Reject</button>
                            </div>
                        </div>

                        <div class="member-item">
                            <div class="member-info">
                                <img src="images/profile2.png" alt="Profile">
                                <div>
                                    <div class="member-name">Siti Zubaidah</div>
                                    <div class="member-id">2025333455</div>
                                </div>
                            </div>
                            <div class="actions">
                                <button class="approve">Approve</button>
                                <button class="reject">Reject</button>
                            </div>
                        </div>

                        <div style="text-align: right; margin-top: 15px;">
                            <a href="newMember.jsp" class="view-btn">View More</a>
                        </div>
                    </div>
                </div>

                <!-- Right: Calendar -->
                <div class="calendar-box">
                    <h4>Upcoming Events Calendar</h4>
                    <div id="calendar"></div>
                    <div id="eventDetails"></div>
                </div>
            </div>
            </div>
            <!-- Footer -->
                <div class="main-footer">
                © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    function toggleSidebar() {
        document.querySelector('.sidebar').classList.toggle('collapsed');
        document.querySelector('.dashboard-container').classList.toggle('sidebar-collapsed');
    }

    const events = {
        "2025-06-15": "Talent Night Auditions",
        "2025-06-22": "Guitar Workshop",
        "2025-06-29": "Club Performance Rehearsal"
    };

    function pad(value) {
        return value.toString().padStart(2, '0');
    }

    function generateCalendar(year, month) {
        const calendar = document.getElementById("calendar");
        calendar.innerHTML = "";

        const date = new Date(year, month, 1);
        const monthName = date.toLocaleString("default", { month: "long" });
        const today = new Date();

        const header = document.createElement("h4");
        header.innerText = `${monthName} ${year}`;
        calendar.appendChild(header);

        const daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
        const daysRow = document.createElement("div");
        daysRow.style.display = "flex";
        daysRow.style.fontWeight = "bold";

        daysOfWeek.forEach(day => {
            const cell = document.createElement("div");
            cell.innerText = day;
            cell.style.flex = "1";
            cell.style.textAlign = "center";
            daysRow.appendChild(cell);
        });
        calendar.appendChild(daysRow);

        let weekRow = document.createElement("div");
        weekRow.style.display = "flex";

        for (let i = 0; i < date.getDay(); i++) {
            const empty = document.createElement("div");
            empty.style.flex = "1";
            weekRow.appendChild(empty);
        }

        while (date.getMonth() === month) {
            const cell = document.createElement("div");
            cell.innerText = date.getDate();
            cell.style.flex = "1";
            cell.style.padding = "5px";
            cell.style.margin = "1px";
            cell.style.borderRadius = "6px";
            cell.style.textAlign = "center";
            cell.style.cursor = "pointer";
            cell.style.fontSize = "12px";

            const key = date.getFullYear() + "-" + pad(date.getMonth() + 1) + "-" + pad(date.getDate());
            if (events[key]) {
                cell.style.backgroundColor = "#ffd93d";
                cell.title = events[key];
            }

            const isToday = date.getDate() === today.getDate() &&
                            date.getMonth() === today.getMonth() &&
                            date.getFullYear() === today.getFullYear();

            if (isToday) {
                cell.style.border = "2px solid #003366";
            }

            cell.onclick = () => {
                const msg = events[key] ? `📌 ${events[key]}` : "No events on this day.";
                document.getElementById("eventDetails").innerText = msg;
            };

            weekRow.appendChild(cell);

            if (date.getDay() === 6) {
                calendar.appendChild(weekRow);
                weekRow = document.createElement("div");
                weekRow.style.display = "flex";
            }

            date.setDate(date.getDate() + 1);
        }

        if (weekRow.children.length > 0) {
            calendar.appendChild(weekRow);
        }
    }

    window.onload = function () {
        const today = new Date();
        generateCalendar(today.getFullYear(), today.getMonth());
    };
</script>
</body>
</html>
