import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get form fields
        String role = request.getParameter("role");
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load Derby JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Connect to Derby database
            conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/UniEventDB", "app", "app");

            // Role-based logic
            if ("Student".equals(role)) {
                String studentId = request.getParameter("studentId");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");

                stmt = conn.prepareStatement(
                    "INSERT INTO STUDENTS (STUDENT_ID, NAME, EMAIL, PHONENUM, PASSWORD) VALUES (?, ?, ?, ?, ?)");
                stmt.setString(1, studentId);
                stmt.setString(2, name);
                stmt.setString(3, email);
                stmt.setString(4, phone);
                stmt.setString(5, password);

            } else if ("Club Organizer".equals(role)) {
                String clubEmail = request.getParameter("clubEmail");

                stmt = conn.prepareStatement(
                    "INSERT INTO CLUB_ORGANIZERS (NAME, EMAIL, PASSWORD) VALUES (?, ?, ?)");
                stmt.setString(1, name);
                stmt.setString(2, clubEmail);
                stmt.setString(3, password);

            } else if ("Admin/Staff".equals(role)) {
                String staffId = request.getParameter("staffId");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");

                stmt = conn.prepareStatement(
                    "INSERT INTO STAFF (STAFF_ID, NAME, EMAIL, PHONENUM, PASSWORD) VALUES (?, ?, ?, ?, ?)");
                stmt.setString(1, staffId);
                stmt.setString(2, name);
                stmt.setString(3, email);
                stmt.setString(4, phone);
                stmt.setString(5, password);
            }

            // Execute and close
            if (stmt != null) {
                int rowsInserted = stmt.executeUpdate();
                System.out.println("Rows inserted: " + rowsInserted);
                stmt.close();
            }

            conn.close();

            // Redirect to login page
            response.sendRedirect("login.jsp");

        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace(out);
        }
    }
}
