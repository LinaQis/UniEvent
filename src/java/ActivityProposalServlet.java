
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/ActivityProposalServlet")
public class ActivityProposalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String category = request.getParameter("category");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/unieventsystem?useSSL=false&allowPublicKeyRetrieval=true", "root", "");

            String sql = "INSERT INTO activity (title, description, location, start_date, end_date, category, status) VALUES (?, ?, ?, ?, ?, ?, 'PENDING')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setString(3, location);
            stmt.setString(4, startDate);
            stmt.setString(5, endDate);
            stmt.setString(6, category);

            stmt.executeUpdate();
            stmt.close();
            conn.close();

            response.sendRedirect("clubActivity.jsp?popup=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("clubActivity.jsp?popup=error");
        }
    }
}
