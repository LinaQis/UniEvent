import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ActivityServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/UniEventDB", "app", "app");
            
            if ("Club Organizer".equals(role)) {
                // Get club activities
                String query = "SELECT * FROM ACTIVITIES WHERE CLUB_ID = (SELECT CLUB_ID FROM CLUB_ORGANIZERS WHERE EMAIL = ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();
                
                request.setAttribute("activities", rs);
                request.getRequestDispatcher("clubActivity.jsp").forward(request, response);
                
                rs.close();
                stmt.close();
            } else if ("Admin/Staff".equals(role)) {
                // Get all activities for approval
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM ACTIVITIES WHERE STATUS = 'PENDING'");
                
                request.setAttribute("pendingActivities", rs);
                request.getRequestDispatcher("staffActivity.jsp").forward(request, response);
                
                rs.close();
                stmt.close();
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/UniEventDB", "app", "app");
            
            if ("add".equals(action) && "Club Organizer".equals(role)) {
                // Add new activity
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String location = request.getParameter("location");
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");
                String category = request.getParameter("category");
                
                // Get club ID
                String clubQuery = "SELECT CLUB_ID FROM CLUB_ORGANIZERS WHERE EMAIL = ?";
                PreparedStatement clubStmt = conn.prepareStatement(clubQuery);
                clubStmt.setString(1, username);
                ResultSet clubRs = clubStmt.executeQuery();
                clubRs.next();
                int clubId = clubRs.getInt("CLUB_ID");
                
                // Insert activity
                String insertQuery = "INSERT INTO ACTIVITIES (TITLE, DESCRIPTION, LOCATION, START_DATE, END_DATE, CATEGORY, CLUB_ID, STATUS) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?, 'PENDING')";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, title);
                insertStmt.setString(2, description);
                insertStmt.setString(3, location);
                insertStmt.setString(4, startDate);
                insertStmt.setString(5, endDate);
                insertStmt.setString(6, category);
                insertStmt.setInt(7, clubId);
                insertStmt.executeUpdate();
                
                clubRs.close();
                clubStmt.close();
                insertStmt.close();
                
                response.sendRedirect("clubActivity.jsp");
                
            } else if ("approve".equals(action) && "Admin/Staff".equals(role)) {
                // Approve activity
                int activityId = Integer.parseInt(request.getParameter("activityId"));
                
                String updateQuery = "UPDATE ACTIVITIES SET STATUS = 'APPROVED' WHERE ACTIVITY_ID = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, activityId);
                updateStmt.executeUpdate();
                updateStmt.close();
                
                response.sendRedirect("staffActivity.jsp");
                
            } else if ("reject".equals(action) && "Admin/Staff".equals(role)) {
                // Reject activity
                int activityId = Integer.parseInt(request.getParameter("activityId"));
                
                String updateQuery = "UPDATE ACTIVITIES SET STATUS = 'REJECTED' WHERE ACTIVITY_ID = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, activityId);
                updateStmt.executeUpdate();
                updateStmt.close();
                
                response.sendRedirect("staffActivity.jsp");
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}