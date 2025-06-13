import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String studentName = "Hanna Lee"; // Optional: can be session
        String studentId = "20202657196";
        String club = request.getParameter("club");
        String event = request.getParameter("event");
        String comments = request.getParameter("comments");
        int rating = 4; // Static star value for now

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/UniEventDB", "app", "app");

            String sql = "INSERT INTO FEEDBACK (STUDENT_NAME, STUDENT_ID, CLUB_NAME, EVENT_NAME, RATING, COMMENTS) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, studentName);
            stmt.setString(2, studentId);
            stmt.setString(3, club);
            stmt.setString(4, event);
            stmt.setInt(5, rating);
            stmt.setString(6, comments);

            stmt.executeUpdate();
            conn.close();

            response.sendRedirect("studentFeedback.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("studentFeedback.jsp?status=error");
        }
    }
}
