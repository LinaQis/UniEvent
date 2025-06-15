package controller;

import dao.AchievementDAO;
import dao.ActivityDAO;
import dao.ClubDAO;
import dao.MeritDAO; // New DAO for merit
import dao.StudentDAO;
import model.Achievement;
import model.Activity;
import model.Club;
import model.MeritEntry; // New model for merit entries
import model.Student;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/student/dashboard") // Mapped to /student/dashboard
public class DashboardControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        // Ensure student is logged in
        if (session == null || session.getAttribute("username") == null || !"Student".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sessionExpired");
            return;
        }

        String studentId = (String) session.getAttribute("username");
        String studentName = (String) session.getAttribute("studentName");
        
        try {
            ActivityDAO activityDAO = new ActivityDAO();
            AchievementDAO achievementDAO = new AchievementDAO();
            StudentDAO studentDAO = new StudentDAO();
            ClubDAO clubDAO = new ClubDAO();
            MeritDAO meritDAO = new MeritDAO(); // Initialize MeritDAO
            
            // Fetch data for student dashboard
            List<Activity> inProgressEvents = activityDAO.getInProgressEventsByStudent(studentId);
            List<Achievement> achievements = achievementDAO.getAchievementsByStudent(studentId);
            List<Student> topStudents = studentDAO.getTopStudents(3); // Top 3 students by merit
            Student currentStudent = studentDAO.getStudentById(studentId); // Get current student's full data (for merit score)
            List<Club> joinedClubs = clubDAO.getJoinedClubs(studentId);
            
            // For Merit Percentage/Score (based on student.student_merit)
            int totalMerit = (currentStudent != null) ? currentStudent.getStudent_merit() : 0;
            // The merit gauge percentage can be based on a max score, or current score directly
            // For a simple display, we'll just pass the total merit.
            // If you need a percentage of completed events out of total joined, use below logic
            long completedEventsCount = activityDAO.getCompletedEventsCount(studentId);
            long totalJoinedEventsCount = activityDAO.getTotalJoinedEventsCount(studentId);

            int meritPercentage = 0; // Or calculate based on your actual merit system criteria
            if (totalJoinedEventsCount > 0) {
                 meritPercentage = (int) (((double)completedEventsCount / totalJoinedEventsCount) * 100);
            }
            
            request.setAttribute("studentName", studentName);
            request.setAttribute("studentId", studentId);
            request.setAttribute("inProgressEvents", inProgressEvents);
            request.setAttribute("achievements", achievements);
            request.setAttribute("topStudents", topStudents);
            request.setAttribute("meritPercentage", meritPercentage); // For dynamic gauge
            request.setAttribute("totalMerit", totalMerit); // For actual merit score display
            request.setAttribute("joinedClubs", joinedClubs);
            request.setAttribute("completedEventsCount", completedEventsCount);
            request.setAttribute("inProgressEventsCount", inProgressEvents.size());


            RequestDispatcher dispatcher = request.getRequestDispatcher("/studentDashboard.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
            System.err.println("SQL Error in DashboardControllerServlet doGet: " + e.getMessage());
            throw new ServletException("Database error in Student Dashboard", e);
        }
    }
}
