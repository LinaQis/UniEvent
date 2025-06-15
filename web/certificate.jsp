<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Achievement Certificate</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Tangerine:wght@700&family=Poppins:wght@400;600&display=swap">
    <style>
        body{background-color:#f4f6f9;display:flex;flex-direction:column;align-items:center;min-height:100vh;padding:20px 0}
        .certificate-container{background-color:#fff;border:10px solid #c0a062;border-radius:15px;box-shadow:0 8px 16px rgba(0,0,0,.2);padding:40px;width:100%;max-width:800px;text-align:center;position:relative;margin-bottom:30px}
        .certificate-header{font-family:'Tangerine',cursive;font-size:4.5em;color:#a07e44;margin-bottom:20px}
        .certificate-award-to{font-family:'Poppins',sans-serif;font-size:1.2em;color:#555;margin-bottom:5px}
        .certificate-name{font-family:'Tangerine',cursive;font-size:3.5em;color:#333;font-weight:700;margin-bottom:30px}
        .certificate-for{font-family:'Poppins',sans-serif;font-size:1.1em;color:#444;margin-bottom:20px;line-height:1.6}
        .certificate-signatures{display:flex;justify-content:space-around;margin-top:60px;width:90%;margin-left:auto;margin-right:auto}
        .signature-block{text-align:center;padding-top:15px;border-top:1px solid #777;width:45%;font-family:'Poppins',sans-serif}
        .print-button{background-color:#6b46f2;color:#fff;padding:10px 20px;border:none;border-radius:8px;cursor:pointer;font-size:1em}
        @media print{body{padding:0;margin:0}.print-button{display:none!important}}
    </style>
</head>
<body>
    <div class="certificate-container">
        <c:choose>
            <c:when test="${not empty achievement}">
                <h1 class="certificate-header">Certificate of Achievement</h1>
                <p class="certificate-award-to">This Certificate is Proudly Presented To</p>
                <h2 class="certificate-name"><c:out value="${sessionScope.studentName}"/></h2>
                <p class="certificate-for">For outstanding achievement and dedication in:<br><strong><c:out value="${achievement.title}"/></strong></p>
                <p class="certificate-reason"><em><c:out value="${achievement.description}"/></em></p>
                <p class="certificate-date">Awarded on: <fmt:formatDate value="${achievement.date_awarded}" pattern="MMMM dd, yyyy"/></p>
                <div class="certificate-signatures">
                    <div class="signature-block">Head of Student Affairs</div>
                    <div class="signature-block">University Rector</div>
                </div>
            </c:when>
            <c:otherwise><p>Certificate not found or invalid ID.</p></c:otherwise>
        </c:choose>
    </div>
    <button class="print-button" onclick="window.print()">Print Certificate</button>
</body>
</html>