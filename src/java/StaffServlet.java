import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class StaffServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!"Admin/Staff".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/unieventsystem?useSSL=false&allowPublicKeyRetrieval=true", "root", "");
            
            // Get staff registration requests
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM STAFF_REQUESTS WHERE STATUS = 'PENDING'");
            
            request.setAttribute("staffRequests", rs);
            request.getRequestDispatcher("staffDashboard.jsp").forward(request, response);
            
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/UniEventDB", "app", "app");
            
            if ("approve".equals(action)) {
                // Get request details
                String query = "SELECT * FROM STAFF_REQUESTS WHERE REQUEST_ID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, requestId);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    // Insert into staff table
                    String insertQuery = "INSERT INTO STAFF (STAFF_ID, NAME, EMAIL, PHONENUM, PASSWORD) " +
                                        "VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                    insertStmt.setString(1, rs.getString("STAFF_ID"));
                    insertStmt.setString(2, rs.getString("NAME"));
                    insertStmt.setString(3, rs.getString("EMAIL"));
                    insertStmt.setString(4, rs.getString("PHONENUM"));
                    insertStmt.setString(5, rs.getString("PASSWORD"));
                    insertStmt.executeUpdate();
                    insertStmt.close();
                    
                    // Update request status
                    String updateQuery = "UPDATE STAFF_REQUESTS SET STATUS = 'APPROVED' WHERE REQUEST_ID = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                    updateStmt.setInt(1, requestId);
                    updateStmt.executeUpdate();
                    updateStmt.close();
                }
                
                rs.close();
                stmt.close();
                
            } else if ("reject".equals(action)) {
                // Update request status
                String updateQuery = "UPDATE STAFF_REQUESTS SET STATUS = 'REJECTED' WHERE REQUEST_ID = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, requestId);
                updateStmt.executeUpdate();
                updateStmt.close();
            }
            
            conn.close();
            response.sendRedirect("staffDashboard.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}