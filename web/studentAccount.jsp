<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Account - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .profile-card{background-color:#fff;padding:30px;border-radius:15px;box-shadow:0 4px 12px rgba(0,0,0,.1);max-width:800px;margin:20px auto}.profile-header{display:flex;align-items:center;gap:25px;margin-bottom:30px;border-bottom:1px solid #eee;padding-bottom:20px}.profile-avatar{width:120px;height:120px;border-radius:50%;object-fit:cover;border:4px solid #0f60b6}.profile-info h3{font-size:28px;color:#003366;margin-bottom:5px}.profile-info p{font-size:16px;color:#666;margin:0}.profile-details-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px 30px;margin-bottom:30px}.detail-item label{font-weight:600;color:#333;margin-bottom:5px;font-size:15px}.detail-item input{background-color:#f9f9f9;color:#555}.detail-item input[readonly]{background-color:#f0f0f0}.action-buttons{display:flex;justify-content:flex-end;gap:15px}.action-buttons button{padding:12px 25px;border:none;border-radius:8px;font-weight:700;cursor:pointer;font-size:16px}.edit-btn,.save-btn{background-color:#4285f4;color:#fff}.cancel-btn{background-color:#ccc;color:#333}@media (max-width:768px){.profile-details-grid{grid-template-columns:1fr}}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Account" scope="request"/>
    <jsp:include page="/includes/studentSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="profile-card">
            <form action="${pageContext.request.contextPath}/student/account" method="post" id="accountForm">
                <input type="hidden" name="action" value="updateAccount">
                <input type="hidden" name="student_no" value="${student.student_no}">

                <div class="profile-header">
                    <img src="${pageContext.request.contextPath}/images/user.jpg" alt="Profile Avatar" class="profile-avatar">
                    <div class="profile-info">
                        <h3>${student.student_name}</h3>
                        <p>${student.student_no}</p>
                    </div>
                </div>

                <div class="profile-details-grid">
                    <div class="detail-item"><label for="studentName">Full Name</label><input type="text" id="studentName" name="student_name" value="${student.student_name}" readonly required></div>
                    <div class="detail-item"><label for="studentID">Student ID</label><input type="text" id="studentID" value="${student.student_no}" readonly></div>
                    <div class="detail-item"><label for="email">Email Address</label><input type="email" id="email" name="student_email" value="${student.student_email}" readonly required></div>
                    <div class="detail-item"><label for="phone">Phone Number</label><input type="tel" id="phone" name="student_phone" value="${student.student_phonenum}" readonly required></div>
                    <div class="detail-item"><label for="faculty">Faculty</label><input type="text" id="faculty" name="student_faculty" value="${student.student_faculty}" readonly></div>
                    <div class="detail-item"><label for="course">Course</label><input type="text" id="course" name="student_course" value="${student.student_course}" readonly></div>
                    <div class="detail-item"><label for="password">New Password</label><input type="password" id="password" name="student_password" placeholder="Leave blank to keep current" readonly></div>
                </div>

                <div class="action-buttons">
                    <button type="button" class="edit-btn" id="editButton">Edit Profile</button>
                    <button type="submit" class="save-btn" id="saveButton" style="display: none;">Save Changes</button>
                    <button type="button" class="cancel-btn" id="cancelButton" style="display: none;">Cancel</button>
                </div>
            </form>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>
    <script>
        document.addEventListener('DOMContentLoaded',()=>{const t=document.querySelectorAll("#accountForm input:not([readonly])"),e=document.getElementById("editButton"),n=document.getElementById("saveButton"),d=document.getElementById("cancelButton"),a=document.getElementById("password");let o={};e.addEventListener("click",()=>{document.querySelectorAll("#accountForm input").forEach(t=>{o[t.id]=t.value,t.readOnly=false,t.style.backgroundColor="#fff"}),a.placeholder="Enter new password to change",e.style.display="none",n.style.display="inline-block",d.style.display="inline-block"}),d.addEventListener("click",()=>{document.querySelectorAll("#accountForm input:not([type=hidden])").forEach(t=>{t.value=o[t.id]||"",t.readOnly=true,t.style.backgroundColor=""}),a.value="",a.placeholder="Leave blank to keep current",e.style.display="inline-block",n.style.display="none",d.style.display="none"})});
    </script>
</body>
</html>