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
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String role = request.getParameter("role");
        String redirectStatus = "error";

        try {
            if ("Student".equals(role)) {
                redirectStatus = registerStudent(request);
            } else if ("Club Organizer".equals(role)) {
                redirectStatus = registerClubOrganizer(request);
            } else if ("Admin/Staff".equals(role)) {
                redirectStatus = registerStaff(request);
            } else {
                response.sendRedirect(request.getContextPath() + "/register.jsp?error=invalidRole");
                return;
            }
            // Redirect to login page with appropriate status message
            response.sendRedirect(request.getContextPath() + "/login.jsp?registration=" + redirectStatus);

        } catch (SQLException e) {
            e.printStackTrace();
            // Check for duplicate entry SQL error
            if (e.getErrorCode() == 1062) { // 1062 is the MySQL error code for duplicate entry
                 response.sendRedirect(request.getContextPath() + "/login.jsp?registration=duplicateId");
            } else {
                 response.sendRedirect(request.getContextPath() + "/login.jsp?registration=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?registration=error");
        }
    }

    /**
     * [FIX] Registers a new student with status set to ACTIVE automatically.
     */
    private String registerStudent(HttpServletRequest request) throws SQLException {
        Student student = new Student();
        student.setStudent_no(request.getParameter("studentId"));
        student.setStudent_name(request.getParameter("name"));
        student.setStudent_email(request.getParameter("email"));
        student.setStudent_phonenum(request.getParameter("phone"));
        student.setStudent_password(request.getParameter("password"));
        student.setStudent_course(request.getParameter("course"));
        student.setStudent_faculty(request.getParameter("faculty"));
        student.setStudent_merit(0);
        // [FIX] Status is now ACTIVE by default, no admin approval needed.
        student.setStudent_status("ACTIVE");

        StudentDAO studentDAO = new StudentDAO();
        studentDAO.registerStudent(student);
        return "success_auto_approved"; // Use a new status for the message
    }

    /**
     * [FIX] Registers a new club organizer with status set to ACTIVE automatically.
     */
    private String registerClubOrganizer(HttpServletRequest request) throws SQLException {
        // First, register them as a student
        Student student = new Student();
        student.setStudent_no(request.getParameter("studentId"));
        student.setStudent_name(request.getParameter("name"));
        student.setStudent_email(request.getParameter("email"));
        student.setStudent_phonenum(request.getParameter("phone"));
        student.setStudent_password(request.getParameter("password"));
        student.setStudent_course(request.getParameter("course"));
        student.setStudent_faculty(request.getParameter("faculty"));
        student.setStudent_merit(0);
        // [FIX] Status is now ACTIVE by default.
        student.setStudent_status("ACTIVE");

        StudentDAO studentDAO = new StudentDAO();
        studentDAO.registerStudent(student);

        // Then, create the club for them
        Club newClub = new Club();
        newClub.setClub_name(request.getParameter("clubName"));
        newClub.setClub_desc(request.getParameter("clubDesc"));
        newClub.setClub_presidentID(student.getStudent_no());
        newClub.setLogo_path("images/default_club_logo.png"); // Default logo
        newClub.setClub_category(request.getParameter("clubCategory"));

        ClubDAO clubDAO = new ClubDAO();
        clubDAO.addClub(newClub);

        return "success_auto_approved";
    }

    /**
     * Registers a new Staff member.
     */
    private String registerStaff(HttpServletRequest request) throws SQLException {
        Staff staff = new Staff();
        staff.setHep_staffid(request.getParameter("staffId"));
        staff.setHep_staffname(request.getParameter("name"));
        staff.setHep_staffemail(request.getParameter("email"));
        staff.setHep_staffphonenum(request.getParameter("phone"));
        staff.setHep_staffpassword(request.getParameter("password"));
        staff.setHep_staffadminstatus("Admin".equalsIgnoreCase(request.getParameter("staffRole")));
        staff.setStaff_role(request.getParameter("staffRole"));

        StaffDAO staffDAO = new StaffDAO();
        staffDAO.addStaff(staff);
        return "success";
    }
}