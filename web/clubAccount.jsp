<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Club Organizer Account</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .profile-card{background-color:#fff;padding:30px;border-radius:15px;box-shadow:0 4px 12px rgba(0,0,0,.1);max-width:800px;margin:20px auto}.profile-header{display:flex;align-items:center;gap:25px;margin-bottom:30px;border-bottom:1px solid #eee;padding-bottom:20px}.profile-avatar{width:120px;height:120px;border-radius:50%;object-fit:cover;border:4px solid #0f60b6}.profile-info h3{font-size:28px;color:#003366;margin-bottom:5px}.profile-info p{font-size:16px;color:#666;margin:0}.profile-details-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px 30px;margin-bottom:30px}.detail-item label{font-weight:600;color:#333;margin-bottom:5px;font-size:15px}.detail-item input{background-color:#f9f9f9;color:#555}.detail-item input[readonly]{background-color:#f0f0f0}.action-buttons{display:flex;justify-content:flex-end;gap:15px}.action-buttons button{padding:12px 25px;border:none;border-radius:8px;font-weight:700;cursor:pointer;font-size:16px}.edit-btn,.save-btn{background-color:#4285f4;color:#fff}.cancel-btn{background-color:#ccc;color:#333}@media (max-width:768px){.profile-details-grid{grid-template-columns:1fr}}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Club Account" scope="request"/>
    <jsp:include page="/includes/clubSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="profile-card">
            <form action="${pageContext.request.contextPath}/club/account" method="post" id="accountForm">
                 <input type="hidden" name="action" value="updateClubAccount">
                <div class="profile-header">
                    <img src="${pageContext.request.contextPath}/images/user.jpg" alt="Profile Avatar" class="profile-avatar">
                    <div class="profile-info">
                        <h3>${organizerStudent.student_name}</h3>
                        <p>Club Organizer</p>
                    </div>
                </div>
                <div class="profile-details-grid">
                    <div class="detail-item"><label for="studentName">Full Name</label><input type="text" id="studentName" name="student_name" value="${organizerStudent.student_name}" readonly required></div>
                    <div class="detail-item"><label for="studentID">Student ID</label><input type="text" id="studentID" value="${organizerStudent.student_no}" readonly></div>
                    <div class="detail-item"><label for="email">Email</label><input type="email" id="email" name="student_email" value="${organizerStudent.student_email}" readonly required></div>
                    <div class="detail-item"><label for="phone">Phone</label><input type="tel" id="phone" name="student_phone" value="${organizerStudent.student_phonenum}" readonly required></div>
                    <div class="detail-item"><label for="password">New Password</label><input type="password" id="password" name="student_password" placeholder="Leave blank to keep current" readonly></div>
                </div>
                <div class="action-buttons">
                    <button type="button" class="edit-btn" id="editButton">Edit</button>
                    <button type="submit" class="save-btn" id="saveButton" style="display: none;">Save</button>
                    <button type="button" class="cancel-btn" id="cancelButton" style="display: none;">Cancel</button>
                </div>
            </form>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
     <script>
        // Reusable script for edit/save functionality
        document.addEventListener('DOMContentLoaded',()=>{const t=document.getElementById("editButton"),e=document.getElementById("saveButton"),n=document.getElementById("cancelButton"),d=document.querySelectorAll("#accountForm input:not([readonly])");let a={};t.addEventListener("click",()=>{d.forEach(t=>{a[t.id]=t.value,t.readOnly=!1,t.style.backgroundColor="#fff"}),document.getElementById("password").placeholder="Enter new password",t.style.display="none",e.style.display="inline-block",n.style.display="inline-block"}),n.addEventListener("click",()=>{d.forEach(t=>{t.value=a[t.id]||"",t.readOnly=!0,t.style.backgroundColor=""}),document.getElementById("password").value="",document.getElementById("password").placeholder="Leave blank to keep current",t.style.display="inline-block",e.style.display="none",n.style.display="none"})});
    </script>
</body>
</html>
