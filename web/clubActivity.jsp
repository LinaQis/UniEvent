<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Club Activities - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        .activity-container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .activity-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .activity-title {
            font-size: 24px;
            font-weight: 600;
            color: #003366;
        }
        
        .add-activity-btn {
            background-color: #4285f4;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        
        .activity-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .activity-card {
            background-color: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .activity-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        .activity-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .status-pending {
            background-color: #FFD93D;
            color: #000;
        }
        
        .status-approved {
            background-color: #32d183;
            color: white;
        }
        
        .status-rejected {
            background-color: #f14c4c;
            color: white;
        }
        
        .activity-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #003366;
        }
        
        .activity-details {
            font-size: 14px;
            color: #555;
            margin-bottom: 8px;
        }
        
        .activity-details strong {
            color: #333;
        }
        
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        
        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 30px;
            border-radius: 10px;
            width: 80%;
            max-width: 600px;
            position: relative;
        }
        
        .close {
            position: absolute;
            top: 15px;
            right: 25px;
            font-size: 28px;
            font-weight: bold;
            color: #aaa;
            cursor: pointer;
        }
        
        .close:hover {
            color: #333;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-family: 'Poppins', sans-serif;
        }
        
        .form-group textarea {
            height: 100px;
            resize: vertical;
        }
        
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        
        .cancel-btn {
            background-color: #f1f1f1;
            color: #333;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
        }
        
        .submit-btn {
            background-color: #4285f4;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
        }
    </style>
</head>
<body class="dashboard-page">
<div class="club-dashboard">
    <!-- Top Navigation Bar -->
    <div class="topbar">
        <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
        <div class="topbar-left">Club Activities</div>
        <div class="topbar-right">THE SOUND CLUB</div>
    </div>

    <div class="dashboard-container">
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <img src="images/logo.png" alt="Logo" class="left-logo">
            <a href="clubDashboard.jsp">Dashboard</a>
            <a href="clubAboutMenu.jsp">About</a>
            <a href="clubFeedback.jsp">Feedback</a>
            <a href="#" class="active">Activity</a>
            <a href="#">Account</a>
        </div>

        <!-- Main Content Area -->
        <div class="main">
            <div class="activity-container">
                <div class="activity-header">
                    <h1 class="activity-title">Club Activities</h1>
                    <button class="add-activity-btn" onclick="openModal()">
                        + Add New Activity
                    </button>
                </div>
                
                <div class="activity-grid">
                    <% 
                        ResultSet activities = (ResultSet) request.getAttribute("activities");
                        if (activities != null) {
                            while (activities.next()) { 
                                String status = activities.getString("STATUS");
                                String statusClass = "";
                                if ("PENDING".equals(status)) statusClass = "status-pending";
                                else if ("APPROVED".equals(status)) statusClass = "status-approved";
                                else if ("REJECTED".equals(status)) statusClass = "status-rejected";
                    %>
                    <div class="activity-card">
                        <span class="activity-status <%= statusClass %>"><%= status %></span>
                        <h3 class="activity-name"><%= activities.getString("TITLE") %></h3>
                        <p class="activity-details"><%= activities.getString("DESCRIPTION") %></p>
                        <p class="activity-details"><strong>Location:</strong> <%= activities.getString("LOCATION") %></p>
                        <p class="activity-details"><strong>Date:</strong> 
                            <%= activities.getString("START_DATE") %> to <%= activities.getString("END_DATE") %>
                        </p>
                        <p class="activity-details"><strong>Category:</strong> <%= activities.getString("CATEGORY") %></p>
                    </div>
                    <% 
                            }
                        } 
                    %>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Activity Modal -->
    <div id="activityModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>Add New Activity</h2>
            <form action="ActivityServlet" method="post" id="activityForm">
                <input type="hidden" name="action" value="add">
                
                <div class="form-group">
                    <label for="title">Activity Title</label>
                    <input type="text" id="title" name="title" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" required></textarea>
                </div>
                
                <div class="form-group">
                    <label for="location">Location</label>
                    <input type="text" id="location" name="location" required>
                </div>
                
                <div class="form-group">
                    <label for="startDate">Start Date & Time</label>
                    <input type="datetime-local" id="startDate" name="startDate" required>
                </div>
                
                <div class="form-group">
                    <label for="endDate">End Date & Time</label>
                    <input type="datetime-local" id="endDate" name="endDate" required>
                </div>
                
                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" required>
                        <option value="">Select a category</option>
                        <option value="Academic">Academic</option>
                        <option value="Sports">Sports</option>
                        <option value="Cultural">Cultural</option>
                        <option value="Social">Social</option>
                        <option value="Workshop">Workshop</option>
                    </select>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="cancel-btn" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="submit-btn">Submit Activity</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
    </div>
</div>

<script>
    // Toggle sidebar
    function toggleSidebar() {
        document.querySelector('.sidebar').classList.toggle('collapsed');
        document.querySelector('.dashboard-container').classList.toggle('sidebar-collapsed');
    }
    
    // Modal functions
    function openModal() {
        document.getElementById('activityModal').style.display = 'block';
    }
    
    function closeModal() {
        document.getElementById('activityModal').style.display = 'none';
    }
    
    // Close modal when clicking outside
    window.onclick = function(event) {
        var modal = document.getElementById('activityModal');
        if (event.target == modal) {
            closeModal();
        }
    }
    
    // Form validation
    document.getElementById('activityForm').addEventListener('submit', function(e) {
        var startDate = new Date(document.getElementById('startDate').value);
        var endDate = new Date(document.getElementById('endDate').value);
        
        if (endDate <= startDate) {
            alert('End date must be after start date');
            e.preventDefault();
        }
    });
</script>
</body>
</html>