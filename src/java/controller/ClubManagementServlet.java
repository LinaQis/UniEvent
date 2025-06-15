package controller;

import dao.ActivityDAO;
import dao.ClubDAO;
import dao.FeedbackDAO;
import dao.StudentDAO;
import model.Activity;
import model.Club;
import model.Feedback;
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
import java.util.List;

@WebServlet("/club/*")
public class ClubManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/dashboard"; // Default to dashboard if no specific path is given
        }
        HttpSession session = request.getSession(false);

        // Security check: Ensure a club organizer is logged in
        if (session == null || session.getAttribute("username") == null || !"Club Organizer".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=auth");
            return;
        }

        try {
            int clubId = (int) session.getAttribute("clubId");
            ClubDAO clubDAO = new ClubDAO();
            Club club = clubDAO.getClubById(clubId);
            request.setAttribute("club", club); // Make club object available to all club JSPs

            switch (action) {
                case "/dashboard":
                    showDashboard(request, response, clubId);
                    break;
                case "/members":
                    showMembers(request, response, clubId);
                    break;
                case "/feedback":
                    showFeedback(request, response, clubId);
                    break;
                case "/about":
                    showAbout(request, response, club);
                    break;
                case "/pastEvents":
                    showPastEvents(request, response, clubId);
                    break;
                case "/account":
                    showAccount(request, response);
                    break;
                case "/activityProposal":
                    showActivityProposalForm(request, response);
                    break;
                
                // --- NEW CASE TO HANDLE ACTIVITY DETAILS ---
                case "/activityDetails":
                    showClubActivityDetails(request, response);
                    break;
                    
                default:
                    // If URL is unknown, default to the dashboard
                    showDashboard(request, response, clubId);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error in ClubManagementServlet", e);
        }
    }

    // --- NEW METHOD TO SHOW ACTIVITY DETAILS FOR THE CLUB ---
    private void showClubActivityDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int activityId = Integer.parseInt(request.getParameter("activity_id"));
        ActivityDAO activityDAO = new ActivityDAO();
        Activity activity = activityDAO.getActivityDetails(activityId);

        request.setAttribute("activity", activity);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubActivityDetails.jsp");
        dispatcher.forward(request, response);
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, int clubId) throws SQLException, ServletException, IOException {
        ActivityDAO activityDAO = new ActivityDAO();
        StudentDAO studentDAO = new StudentDAO();
        
        List<Activity> upcomingEvents = activityDAO.getUpcomingEventsByClub(clubId);
        List<Student> newMembers = studentDAO.getNewMembersForClub(clubId, 5);
        int totalMembers = studentDAO.getClubMembers(clubId).size();
        int approvedActivitiesCount = activityDAO.getApprovedActivitiesCount();
        int pendingActivitiesCount = activityDAO.getPendingActivitiesCount();

        request.setAttribute("upcomingEvents", upcomingEvents);
        request.setAttribute("newMembers", newMembers);
        request.setAttribute("totalMembers", totalMembers);
        request.setAttribute("approvedActivitiesCount", approvedActivitiesCount);
        request.setAttribute("pendingActivitiesCount", pendingActivitiesCount);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubDashboard.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showMembers(HttpServletRequest request, HttpServletResponse response, int clubId) throws SQLException, ServletException, IOException {
        StudentDAO studentDAO = new StudentDAO();
        List<Student> members = studentDAO.getClubMembers(clubId);
        request.setAttribute("members", members);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubMembers.jsp");
        dispatcher.forward(request, response);
    }

    private void showFeedback(HttpServletRequest request, HttpServletResponse response, int clubId) throws SQLException, ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Feedback> feedbackList = feedbackDAO.getFeedbackForClub(clubId);
        request.setAttribute("feedbackList", feedbackList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubFeedback.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showAbout(HttpServletRequest request, HttpServletResponse response, Club club) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubAbout.jsp");
        dispatcher.forward(request, response);
    }

    private void showPastEvents(HttpServletRequest request, HttpServletResponse response, int clubId) throws SQLException, ServletException, IOException {
        ActivityDAO activityDAO = new ActivityDAO();
        List<Activity> pastEvents = activityDAO.getPastEventsByClub(clubId);
        request.setAttribute("pastEvents", pastEvents);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubPastEvents.jsp");
        dispatcher.forward(request, response);
    }

    private void showAccount(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String organizerId = (String) request.getSession().getAttribute("username");
        StudentDAO studentDAO = new StudentDAO();
        Student organizerStudent = studentDAO.getStudentById(organizerId);
        
        request.setAttribute("organizerStudent", organizerStudent);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubAccount.jsp");
        dispatcher.forward(request, response);
    }

    private void showActivityProposalForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubActivityProposal.jsp");
        dispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method is not supported by this servlet.");
    }
}
