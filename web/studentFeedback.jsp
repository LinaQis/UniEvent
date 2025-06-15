<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback - UniEvent</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .feedback-form-card{background-color:#fff;padding:30px;border-radius:15px;box-shadow:0 4px 12px rgba(0,0,0,.1);margin-bottom:30px;max-width:800px;margin-left:auto;margin-right:auto}.feedback-form-card h4{font-size:22px;color:#003366;margin-bottom:20px;text-align:center}.rating{display:flex;gap:5px;font-size:30px;color:#ffd93d;cursor:pointer;justify-content:center;margin-bottom:20px}.star{transition:transform .2s ease}.star:hover{transform:scale(1.1)}.submit-feedback-btn{background-color:#0f60b6;color:#fff;padding:12px 25px;border:none;border-radius:8px;font-weight:700;cursor:pointer;font-size:16px;width:100%}.past-feedback-section h4{font-size:22px;color:#003366;margin-bottom:20px;text-align:center}.feedback-list{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:20px}.feedback-card{background-color:#fff;border-radius:12px;padding:20px;box-shadow:0 4px 8px rgba(0,0,0,.1)}.feedback-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:10px}.feedback-profile{display:flex;align-items:center;gap:10px}.feedback-profile img{width:40px;height:40px;border-radius:50%;object-fit:cover}.feedback-name-date{font-weight:600;font-size:15px;color:#333}.feedback-activity-tag{background-color:#c6c2dd;color:#333;padding:5px 12px;border-radius:20px;font-size:12px;font-weight:600}.feedback-stars{color:#ffd93d;margin-top:5px;font-size:18px}.feedback-comment{font-size:14px;line-height:1.5;color:#555}
    </style>
</head>
<body class="dashboard-page">
    <c:set var="pageTitle" value="Feedback" scope="request"/>
    <jsp:include page="/includes/studentSidebar.jsp" />

    <div class="main-content">
        <jsp:include page="/includes/mainHeader.jsp" />
        <div class="feedback-form-card">
            <h4>Submit New Feedback</h4>
            <form action="${pageContext.request.contextPath}/FeedbackServlet" method="post">
                <input type="hidden" name="action" value="submitFeedback">
                <div class="form-group">
                    <label for="activityId">Select Completed Activity</label>
                    <select id="activityId" name="activity_id" required>
                        <option value="">-- Select an activity --</option>
                        <c:forEach var="activity" items="${attendedActivities}">
                            <option value="${activity.activity_id}">${activity.activity_name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Overall Rating</label>
                    <div class="rating" id="starRating">
                        <span class="star" data-value="1">☆</span><span class="star" data-value="2">☆</span><span class="star" data-value="3">☆</span><span class="star" data-value="4">☆</span><span class="star" data-value="5">☆</span>
                    </div>
                    <input type="hidden" name="rating" id="ratingInput" value="0" required>
                </div>
                <div class="form-group">
                    <label for="comment">Your Comment</label>
                    <textarea id="comment" name="comment" placeholder="Share your thoughts..." rows="5" required></textarea>
                </div>
                <button type="submit" class="submit-feedback-btn">Submit Feedback</button>
            </form>
        </div>

        <div class="past-feedback-section">
            <h4>Your Past Feedback</h4>
            <div class="feedback-list">
                <c:choose>
                    <c:when test="${not empty studentFeedbackList}"><c:forEach var="feedback" items="${studentFeedbackList}">
                        <div class="feedback-card">
                            <div class="feedback-header">
                                <div>
                                    <div class="feedback-name-date">You on <fmt:formatDate value="${feedback.feedback_date}" pattern="dd MMM, yyyy"/></div>
                                    <div class="feedback-stars"><c:forEach begin="1" end="${feedback.feedback_rating}">★</c:forEach><c:forEach begin="${feedback.feedback_rating + 1}" end="5">☆</c:forEach></div>
                                </div>
                                <div class="feedback-activity-tag">${feedback.activity_name}</div>
                            </div>
                            <p class="feedback-comment"><c:out value="${feedback.feedback_comment}"/></p>
                        </div>
                    </c:forEach></c:when>
                    <c:otherwise><p>You haven't submitted any feedback yet.</p></c:otherwise>
                </c:choose>
            </div>
        </div>
        <jsp:include page="/includes/mainFooter.jsp" />
    </div>

    <script>
        document.addEventListener('DOMContentLoaded',function(){const t=document.getElementById("starRating"),e=document.getElementById("ratingInput");let n=0;function d(a=n){Array.from(t.children).forEach(t=>{const e=parseInt(t.dataset.value);t.textContent=e<=a?"★":"☆"})}t.addEventListener("click",a=>{a.target.classList.contains("star")&&(n=parseInt(a.target.dataset.value),e.value=n,d())}),t.addEventListener("mouseover",t=>{t.target.classList.contains("star")&&d(parseInt(t.target.dataset.value))}),t.addEventListener("mouseout",()=>{d()}),d()});
    </script>
</body>
</html>