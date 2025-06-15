package controller;

import dao.FeedbackDAO;
import model.Feedback;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date; // For new Date()

/**
 * Servlet to handle feedback submission and possibly other feedback-related actions.
 * Renamed from SubmitFeedbackServlet for better consistency.
 */
@WebServlet("/FeedbackServlet") // Consistent naming
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null || !"Student".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sessionExpired");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String popupStatus = "error"; // Default status

        try {
            if ("submitFeedback".equals(action)) {
                String studentId = (String) session.getAttribute("username");
                int activityId = Integer.parseInt(request.getParameter("activity_id"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comments = request.getParameter("comment"); // Corrected to 'comment' as per JSP

                Feedback feedback = new Feedback();
                feedback.setStudent_no(studentId);
                feedback.setActivity_id(activityId);
                feedback.setFeedback_rating(rating);
                feedback.setFeedback_comment(comments);
                feedback.setFeedback_date(new java.sql.Timestamp(new Date().getTime())); // Set current timestamp

                FeedbackDAO feedbackDAO = new FeedbackDAO();
                feedbackDAO.addFeedback(feedback);
                popupStatus = "success";
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action for feedback.");
                return;
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            System.err.println("Invalid number format for activity ID or rating: " + e.getMessage());
            popupStatus = "error";
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL Error submitting feedback: " + e.getMessage());
            popupStatus = "error";
        } finally {
            response.sendRedirect(request.getContextPath() + "/student/feedback?feedback=" + popupStatus);
        }
    }
}
