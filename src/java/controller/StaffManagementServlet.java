package controller;

import dao.ActivityDAO;
import dao.ClubDAO;
import dao.FeedbackDAO;
import dao.StaffDAO;
import dao.StudentDAO;
import model.Activity;
import model.Club;
import model.Feedback;
import model.Staff;
import model.Student;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/staff/*")
public class StaffManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo() == null ? "/dashboard" : request.getPathInfo();
        HttpSession session = request.getSession(false);

        if (session == null || !"Admin/Staff".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=auth");
            return;
        }

        try {
            switch (action) {
                case "/dashboard":
                    showDashboard(request, response);
                    break;
                case "/activities":
                    showActivities(request, response);
                    break;
                case "/activityDetails":
                    showActivityDetails(request, response);
                    break;
                case "/reports":
                    showReports(request, response);
                    break;
                case "/feedback":
                    showFeedback(request, response);
                    break;
                case "/account":
                    showAccount(request, response);
                    break;
                default:
                    showDashboard(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error in StaffManagementServlet doGet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        if (session == null || !"Admin/Staff".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=auth");
            return;
        }
        String staffId = (String) session.getAttribute("username");

        try {
            switch (action) {
                case "approveActivity":
                case "rejectActivity":
                    handleActivityApproval(request, response, staffId);
                    break;
                case "updateAccount":
                    updateStaffAccount(request, response, staffId);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action for staff management.");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error in StaffManagementServlet doPost", e);
        }
    }

    private void handleActivityApproval(HttpServletRequest request, HttpServletResponse response, String staffId) throws SQLException, IOException {
        int activityId = Integer.parseInt(request.getParameter("activity_id"));
        String action = request.getParameter("action");
        String status = "approveActivity".equals(action) ? "APPROVED" : "REJECTED";
        
        ActivityDAO activityDAO = new ActivityDAO();
        activityDAO.updateActivityStatus(activityId, status, staffId);
        
        response.sendRedirect(request.getContextPath() + "/staff/activities?update=success");
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        ActivityDAO activityDAO = new ActivityDAO();
        ClubDAO clubDAO = new ClubDAO();
        StudentDAO studentDAO = new StudentDAO();
        
        request.setAttribute("totalActivities", activityDAO.getTotalActivitiesCount());
        request.setAttribute("totalStudents", studentDAO.getTotalStudentsCount());
        request.setAttribute("totalClubs", clubDAO.getTotalClubsCount());
        
        List<Activity> pendingActivities = activityDAO.getPendingActivities();
        request.setAttribute("pendingActivities", pendingActivities);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/staffDashboard.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showActivities(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        ActivityDAO activityDAO = new ActivityDAO();
        List<Activity> activities = activityDAO.getAllActivitiesWithClubAndCategoryNames();
        request.setAttribute("activities", activities);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/staffActivity.jsp");
        dispatcher.forward(request, response);
    }

    private void showActivityDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int activityId = Integer.parseInt(request.getParameter("activity_id"));
        ActivityDAO activityDAO = new ActivityDAO();
        Activity activity = activityDAO.getActivityDetails(activityId);

        if (activity != null) {
            String rawCommitteeList = activity.getCommittee_list();
            if (rawCommitteeList != null && !rawCommitteeList.isEmpty()) {
                List<String> committeeMembers = Arrays.stream(rawCommitteeList.split("\\R"))
                                                     .map(String::trim)
                                                     .filter(line -> !line.isEmpty())
                                                     .collect(Collectors.toList());
                request.setAttribute("committeeMembers", committeeMembers);
            } else {
                request.setAttribute("committeeMembers", Collections.emptyList());
            }
        }
        
        request.setAttribute("activity", activity);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/staffActivityDetails.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showReports(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        ActivityDAO activityDAO = new ActivityDAO();
        List<Activity> reports = activityDAO.getAllActivitiesWithClubAndCategoryNames(); // You might want a more specific DAO method here
        request.setAttribute("reports", reports);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/staffReports.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showFeedback(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Feedback> allFeedback = feedbackDAO.getAllFeedbackWithStudentAndActivityDetails();
        request.setAttribute("allFeedback", allFeedback);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/staffFeedback.jsp");
        dispatcher.forward(request, response);
    }

    private void showAccount(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        StaffDAO staffDAO = new StaffDAO();
        String staffId = (String) request.getSession().getAttribute("username");
        Staff staff = staffDAO.getStaffById(staffId);
        request.setAttribute("staff", staff);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/staffAccount.jsp");
        dispatcher.forward(request, response);
    }

    private void updateStaffAccount(HttpServletRequest request, HttpServletResponse response, String staffId) throws SQLException, IOException {
        String staffName = request.getParameter("staff_name");
        String staffEmail = request.getParameter("staff_email");
        String staffPhone = request.getParameter("staff_phone");
        String newPassword = request.getParameter("staff_password");

        StaffDAO staffDAO = new StaffDAO();
        Staff staff = staffDAO.getStaffById(staffId);
        
        if (staff != null) {
            staff.setHep_staffname(staffName);
            staff.setHep_staffemail(staffEmail);
            staff.setHep_staffphonenum(staffPhone);
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                staff.setHep_staffpassword(newPassword);
            }
            
            staffDAO.updateStaff(staff);
            request.getSession().setAttribute("staffName", staffName); // Update session name
            response.sendRedirect(request.getContextPath() + "/staff/account?update=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/staff/account?update=error");
        }
    }
}
