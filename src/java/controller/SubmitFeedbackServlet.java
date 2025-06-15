package controller;

import dao.FeedbackDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Feedback;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp?error=sessionExpired");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String studentId = (String) session.getAttribute("username");
        String club = request.getParameter("club"); // You might need to get club_id instead
        int activityId = Integer.parseInt(request.getParameter("event")); // Assuming form sends activity_id
        String comments = request.getParameter("comments");
        int rating = Integer.parseInt(request.getParameter("rating"));

        Feedback feedback = new Feedback();
        feedback.setStudent_no(studentId);
        feedback.setActivity_id(activityId);
        feedback.setFeedback_rating(rating);
        feedback.setFeedback_comment(comments);

        FeedbackDAO feedbackDAO = new FeedbackDAO();
        try {
            feedbackDAO.addFeedback(feedback);
            response.sendRedirect("studentFeedback.jsp?status=success");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("studentFeedback.jsp?status=error");
        }
    }
}