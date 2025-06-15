<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- This JSP provides the common footer for student-facing pages --%>
<style>
    /* Footer styles (ensure these match your main CSS or are included there) */
    .page-footer, .main-footer { /* Both classes for flexibility */
        margin-left: 220px; /* Default margin for expanded sidebar */
        text-align: center;
        padding: 12px;
        background-color: #e0e0e0;
        color: #111;
        font-size: 14px;
        font-weight: 500;
        transition: margin-left 0.3s ease;
        position: relative; /* Essential for relative positioning */
        width: calc(100% - 220px); /* Adjust width for sidebar */
        box-sizing: border-box; /* Include padding in width */
    }
    /* Adjusted styles when sidebar is collapsed */
    .sidebar.collapsed ~ .main-content-wrapper + .page-footer,
    .dashboard-container.sidebar-collapsed .page-footer,
    .dashboard-container.sidebar-collapsed .main-footer {
        margin-left: 60px;
        width: calc(100% - 60px);
    }
</style>
<footer class="page-footer" id="page-footer">
    © Hak Cipta Universiti Teknologi MARA Cawangan Terengganu 2020
</footer>
