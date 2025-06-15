package controller;

import dao.ClubDAO;
import dao.StaffDAO;
import dao.StudentDAO;
import model.Club;
import model.Staff;
import model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // "Student", "Club Organizer", "Admin/Staff"

        String redirectPath = request.getContextPath() + "/login.jsp?error=wrongCredentials"; // Default error redirect
        boolean isAuthenticated = false;

        try {
            if ("Student".equals(role)) {
                StudentDAO studentDAO = new StudentDAO();
                Student student = studentDAO.login(username, password); // Checks for ACTIVE status during login
                if (student != null) {
                    isAuthenticated = true;
                    HttpSession session = request.getSession();
                    session.setAttribute("username", student.getStudent_no());
                    session.setAttribute("studentName", student.getStudent_name());
                    session.setAttribute("role", role);
                    redirectPath = request.getContextPath() + "/student/dashboard";
                } else {
                    // Specific error for pending/rejected students or wrong credentials
                    Student tempStudent = studentDAO.getStudentById(username);
                    if (tempStudent != null && "PENDING".equals(tempStudent.getStudent_status())) {
                         redirectPath = request.getContextPath() + "/login.jsp?error=pendingApproval";
                    } else if (tempStudent != null && "REJECTED".equals(tempStudent.getStudent_status())) {
                         redirectPath = request.getContextPath() + "/login.jsp?error=rejectedAccount";
                    } else {
                         redirectPath = request.getContextPath() + "/login.jsp?error=wrongCredentials";
                    }
                }
            } else if ("Club Organizer".equals(role)) {
                // Club organizer is a student who is also a club president
                StudentDAO studentDAO = new StudentDAO();
                Student student = studentDAO.login(username, password); // Check student credentials and ACTIVE status
                 if (student != null) {
                    ClubDAO clubDAO = new ClubDAO();
                    Club club = clubDAO.getClubByPresident(student.getStudent_no()); // Check if this student is a president
                     if(club != null){
                        isAuthenticated = true;
                        HttpSession session = request.getSession();
                        session.setAttribute("username", student.getStudent_no());
                        session.setAttribute("studentName", student.getStudent_name());
                        session.setAttribute("role", role);
                        session.setAttribute("clubId", club.getClub_id());
                        session.setAttribute("clubName", club.getClub_name()); // Set club name for display
                        redirectPath = request.getContextPath() + "/club/dashboard";
                     } else {
                         // Student exists but is not a club president
                         redirectPath = request.getContextPath() + "/login.jsp?error=notOrganizer";
                     }
                 }
            } else if ("Admin/Staff".equals(role)) {
                StaffDAO staffDAO = new StaffDAO();
                Staff staff = staffDAO.login(username, password);
                if (staff != null) {
                    isAuthenticated = true;
                    HttpSession session = request.getSession();
                    session.setAttribute("username", staff.getHep_staffid());
                    session.setAttribute("staffName", staff.getHep_staffname());
                    session.setAttribute("role", role);
                    // Optionally, set admin status
                    session.setAttribute("isAdmin", staff.isHep_staffadminstatus());
                    redirectPath = request.getContextPath() + "/staff/dashboard";
                }
            }

            // Redirect based on authentication status
            response.sendRedirect(redirectPath);

        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
            System.err.println("SQL Error in LoginServlet: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=databaseError");
        } catch (Exception e) {
            e.printStackTrace(); // Catch any other unexpected errors
            System.err.println("General Error in LoginServlet: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=generalError");
        }
    }
}
