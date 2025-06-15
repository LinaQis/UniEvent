package controller;

import dao.RegistrationDAO; // New DAO for registrations
import dao.ActivityDAO; // To check activity status or participant count

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet to handle student event registrations.
 */
@WebServlet("/EventRegistrationServlet")
public class EventRegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        // Ensure student is logged in
        if (session == null || session.getAttribute("username") == null || !"Student".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sessionExpired");
            return;
        }

        String studentId = (String) session.getAttribute("username");
        String action = request.getParameter("action");
        String popupStatus = "error"; // Default popup status

        try {
            if ("register".equals(action)) {
                int activityId = Integer.parseInt(request.getParameter("activity_id"));
                
                RegistrationDAO registrationDAO = new RegistrationDAO();
                ActivityDAO activityDAO = new ActivityDAO();

                // Check if student is already registered
                if (registrationDAO.isStudentRegisteredForActivity(studentId, activityId)) {
                    popupStatus = "already_registered";
                } else {
                    // Optionally, check activity status and participant limit before registering
                    // Activity activity = activityDAO.getActivityDetails(activityId);
                    // if (activity != null && "APPROVED".equals(activity.getActivity_status()) && activity.getCurrentParticipants() < activity.getParticipant_limit()) {
                    
                    registrationDAO.registerStudentForActivity(studentId, activityId);
                    popupStatus = "success";
                    // Optionally increment current participant count in Activity table if you track it
                    // activityDAO.incrementParticipantCount(activityId);
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action for registration.");
                return;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.err.println("Invalid Activity ID: " + e.getMessage());
            popupStatus = "error";
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL Error during event registration: " + e.getMessage());
            popupStatus = "error";
        } finally {
            // Redirect back to the events page with a status message
            response.sendRedirect(request.getContextPath() + "/student/events?registration=" + popupStatus);
        }
    }
}
