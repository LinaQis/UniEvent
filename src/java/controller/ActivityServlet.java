package controller;

import dao.ActivityDAO;
import model.Activity;

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

/**
 * This servlet primarily handles requests related to displaying activities for Club Organizers.
 * Staff-related activity management (approval/rejection) and student activity views are now
 * handled by StaffManagementServlet and StudentManagementServlet respectively.
 */
@WebServlet("/club/activities") // Mapped to /club/activities
public class ActivityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        // Ensure user is logged in and is a Club Organizer
        if (session == null || session.getAttribute("username") == null || !"Club Organizer".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sessionExpired");
            return;
        }

        try {
            int clubId = (int) session.getAttribute("clubId"); // Club Organizer's club ID
            ActivityDAO activityDAO = new ActivityDAO();
            
            // Fetch all activities for the logged-in club
            List<Activity> activities = activityDAO.getActivitiesByClub(clubId);
            request.setAttribute("activities", activities);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("/clubActivity.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
            throw new ServletException("Database error in ActivityServlet (Club Organizer)", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This servlet is now primarily for GET requests for Club Organizers.
        // Activity approval/rejection actions are moved to StaffManagementServlet.
        // For any POST action specific to club organizers (e.g., updating activity details by organizer),
        // add specific logic here.
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST requests are not supported directly on /club/activities for this action. Use specific servlets.");
    }
}
