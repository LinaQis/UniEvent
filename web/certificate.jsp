<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    String studentName = (String) session.getAttribute("studentName");
    if (studentName == null) studentName = "Hanna Lee";

    String certId = request.getParameter("certId");
    String reason = "successfully completed the requirements.";
    
    if ("1".equals(certId)) {
        reason = "participating in the Leadership Camp 2025.";
    } else if ("2".equals(certId)) {
        reason = "contributing in the Community Service Program.";
    } else if ("3".equals(certId)) {
        reason = "excellent performance in club activities.";
    }

    String currentDate = new java.text.SimpleDateFormat("dd MMMM yyyy").format(new Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Award Certificate</title>
    <style>
        body {
            margin: 0;
            padding: 60px 0;
            background: #eee;
            font-family: 'Georgia', serif;
        }

        .certificate-container {
            width: 900px;
            margin: auto;
            padding: 60px 50px;
            background: #fff url('images/cert-bg.png');
            background-size: cover;
            border: 14px solid #0e3c68;
            outline: 6px solid #b5cfff;
            position: relative;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            text-align: center;
        }

        .certificate-container h1 {
            font-size: 48px;
            color: #000c2b;
            margin-bottom: 40px;
        }

        .certificate-container p {
            font-size: 18px;
            color: #111;
            margin: 10px 0;
        }

        .name {
            font-size: 26px;
            font-weight: bold;
            margin: 20px 0;
            color: #001f47;
        }

        .reason {
            font-style: italic;
            color: #444;
        }

        .signature-block {
            display: flex;
            justify-content: space-between;
            margin-top: 60px;
            padding: 0 40px;
        }

        .signature {
            width: 200px;
            border-top: 1px solid #000;
            padding-top: 5px;
            font-size: 14px;
        }

        .ribbon {
            position: absolute;
            bottom: 60px;
            left: 50%;
            transform: translateX(-50%);
        }

        .print-btn {
            display: block;
            margin: 30px auto;
            padding: 10px 20px;
            background-color: #0e3c68;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }

        @media print {
            .print-btn {
                display: none;
            }
        }
    </style>
</head>
<body>

<div class="certificate-container">
    <h1>Award Certificate</h1>
    
    <p>Presented to</p>
    <div class="name"><%= studentName %></div>
    
    <p>for</p>
    <p class="reason"><%= reason %></p>

    <div class="signature-block">
        <div class="signature">YBRS. DR. ERMEEY ABD. KADIR(REKTOR UNIVERSITI TEKNOLOGI MARA,KUALA TERENGGANU)</div>
        <div class="signature"><%= currentDate %></div>
    </div>

    <div class="ribbon">
        <img src="images/logo.png" alt="UniEvent" width="80">
    </div>
</div>

<button class="print-btn" onclick="window.print()">Print Certificate</button>

</body>
</html>
