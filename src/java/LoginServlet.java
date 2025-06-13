import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        boolean userExists = false;
        boolean isAuthenticated = false;
        String redirectPage = "login.jsp?error=1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/unieventsystem?useSSL=false&allowPublicKeyRetrieval=true", "root", "");

            String query = "";
            if ("Student".equals(role)) {
                query = "SELECT * FROM STUDENTS WHERE STUDENT_ID = ? AND PASSWORD = ?";
                redirectPage = "dashboard"; // go to controller
            } else if ("Club Organizer".equals(role)) {
                query = "SELECT * FROM CLUB_ORGANIZERS WHERE EMAIL = ? AND PASSWORD = ?";
                redirectPage = "clubDashboard.jsp";
            } else if ("Admin/Staff".equals(role)) {
                query = "SELECT * FROM STAFF WHERE STAFF_ID = ? AND PASSWORD = ?";
                redirectPage = "staffDashboard.jsp";
            }

            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                isAuthenticated = true;
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                if ("Student".equals(role)) {
                    String fullName = rs.getString("NAME");
                    session.setAttribute("studentName", fullName);
                }
            }

            rs.close();
            stmt.close();
            conn.close();

            if (isAuthenticated) {
                response.sendRedirect(redirectPage);
            } else {
                // check user existence
                if ("Student".equals(role)) {
                    query = "SELECT * FROM STUDENTS WHERE STUDENT_ID = ?";
                } else if ("Club Organizer".equals(role)) {
                    query = "SELECT * FROM CLUB_ORGANIZERS WHERE EMAIL = ?";
                } else if ("Admin/Staff".equals(role)) {
                    query = "SELECT * FROM STAFF WHERE STAFF_ID = ?";
                }

                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/UniEventDB", "app", "app");
                stmt = conn.prepareStatement(query);
                stmt.setString(1, username);
                rs = stmt.executeQuery();

                if (rs.next()) userExists = true;

                rs.close();
                stmt.close();
                conn.close();

                if (userExists) {
                    response.sendRedirect("login.jsp?error=wrongpass");
                } else {
                    response.sendRedirect("login.jsp?error=nouser");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Login Error: " + e.getMessage() + "</h3>");
        }
    }
}
