package controller;

import dao.AchievementDAO;
import dao.ActivityDAO;
import dao.ClubDAO;
import dao.MeritDAO;
import dao.StudentDAO;
import dao.FeedbackDAO;
import model.Achievement;
import model.Activity;
import model.Club;
import model.MeritEntry;
import model.Student;
import model.Feedback;

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
// Import Set and LinkedHashSet for handling unique categories
import java.util.Set;
import java.util.LinkedHashSet;

/**
 * This servlet centralizes all GET requests for student-facing pages
 * (except the main dashboard, which is handled by DashboardControllerServlet).
 * It also handles POST requests for student account updates.
 */
@WebServlet("/student/*") // Maps all requests under /student/
public class StudentManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo(); // e.g., /clubs, /events, /account
        if (action == null) {
            action = "/dashboard"; // Default action
        }
        HttpSession session = request.getSession(false);

        // Session validation for Student role
        if (session == null || session.getAttribute("username") == null || !"Student".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sessionExpired");
            return;
        }

        String studentId = (String) session.getAttribute("username");
        
        try {
            switch (action) {
                case "/clubs":
                    showClubs(request, response, studentId);
                    break;
                case "/clubDetails":
                    showClubDetails(request, response);
                    break;
                case "/events":
                    showEvents(request, response, studentId);
                    break;
                case "/merit":
                    showMerit(request, response, studentId);
                    break;
                case "/achievements":
                    showAchievements(request, response, studentId);
                    break;
                case "/feedback":
                    showFeedback(request, response, studentId);
                    break;
                case "/account":
                    showAccount(request, response, studentId);
                    break;
                case "/activityHistory": // New case for student's registered activity history
                    showActivityHistory(request, response, studentId);
                    break;
                case "/eventDetails": // Generic event details page for students
                    showEventDetails(request, response, studentId);
                    break;
                default:
                    // Default to dashboard if no specific action or unknown action
                    response.sendRedirect(request.getContextPath() + "/student/dashboard");
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
            System.err.println("SQL Error in StudentManagementServlet doGet: " + e.getMessage());
            throw new ServletException("Database error accessing student page.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        // Session validation for Student role
        if (session == null || session.getAttribute("username") == null || !"Student".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=auth");
            return;
        }
        String studentId = (String) session.getAttribute("username");

        try {
            if ("updateAccount".equals(action)) { // Action to update student's personal account
                updateStudentAccount(request, response, studentId);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action for student management.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL Error in StudentManagementServlet doPost: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/student/account?update=error"); // Redirect with error
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("General Error in StudentManagementServlet doPost: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/student/account?update=error"); // Redirect with error
        }
    }

    /**
     * Handles displaying all clubs and preparing unique categories for filtering.
     * This is the corrected version.
     */
    private void showClubs(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, ServletException, IOException {
        ClubDAO clubDAO = new ClubDAO();
        List<Club> clubs = clubDAO.getAllClubs();

        // Use a Set to automatically handle uniqueness of categories
        Set<String> uniqueCategories = new LinkedHashSet<>();
        if (clubs != null) {
            for (Club club : clubs) {
                if (club.getClub_category() != null && !club.getClub_category().trim().isEmpty()) {
                    uniqueCategories.add(club.getClub_category());
                }
            }
        }

        request.setAttribute("clubs", clubs);
        request.setAttribute("categories", uniqueCategories); // Pass the Set of unique categories to the JSP

        // Forward to the corrected JSP file
        RequestDispatcher dispatcher = request.getRequestDispatcher("/studentClubs.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles displaying details of a specific club.
     */
    private void showClubDetails(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int clubId = Integer.parseInt(request.getParameter("club_id"));
        ClubDAO clubDAO = new ClubDAO();
        Club club = clubDAO.getClubById(clubId);
        
        request.setAttribute("club", club);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/clubDetails.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles displaying all available events for students to register.
     */
    private void showEvents(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, ServletException, IOException {
        ActivityDAO activityDAO = new ActivityDAO();
        List<Activity> availableActivities = activityDAO.getApprovedUpcomingEvents(); 
        
        for (Activity activity : availableActivities) {
            boolean isRegistered = new dao.RegistrationDAO().isStudentRegisteredForActivity(studentId, activity.getActivity_id());
            activity.setRegistered(isRegistered);
        }

        request.setAttribute("availableActivities", availableActivities);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/studentEvents.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles displaying student's merit history.
     */
    private void showMerit(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, ServletException, IOException {
        StudentDAO studentDAO = new StudentDAO();
        MeritDAO meritDAO = new MeritDAO();
        
        Student student = studentDAO.getStudentById(studentId);
        int totalMerit = (student != null) ? student.getStudent_merit() : 0;
        List<MeritEntry> meritHistory = meritDAO.getMeritHistoryByStudent(studentId);

        request.setAttribute("totalMerit", totalMerit);
        request.setAttribute("meritHistory", meritHistory);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/studentMerit.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles displaying student's achievements.
     */
    private void showAchievements(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, ServletException, IOException {
        AchievementDAO achievementDAO = new AchievementDAO();
        List<Achievement> achievements = achievementDAO.getAchievementsByStudent(studentId);
        request.setAttribute("achievements", achievements);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/studentAchievements.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles displaying student's feedback submission form and past feedback.
     */
    private void showFeedback(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        ActivityDAO activityDAO = new ActivityDAO();
        
        List<Activity> attendedActivities = activityDAO.getRegisteredActivitiesByStudent(studentId); 
        attendedActivities.removeIf(activity -> !activity.isCompleted() || !"APPROVED".equals(activity.getActivity_status()));

        List<Feedback> studentFeedbackList = feedbackDAO.getFeedbackByStudent(studentId);

        request.setAttribute("attendedActivities", attendedActivities);
        request.setAttribute("studentFeedbackList", studentFeedbackList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/studentFeedback.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles displaying student's account details.
     */
    private void showAccount(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, ServletException, IOException {
        StudentDAO studentDAO = new StudentDAO();
        Student student = studentDAO.getStudentById(studentId);
        request.setAttribute("student", student);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/studentAccount.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles updating the student's personal account information.
     */
    private void updateStudentAccount(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, IOException {
        String studentName = request.getParameter("student_name");
        String studentEmail = request.getParameter("student_email");
        String studentPhone = request.getParameter("student_phone");
        String newPassword = request.getParameter("student_password");
        String studentCourse = request.getParameter("student_course");
        String studentFaculty = request.getParameter("student_faculty");

        StudentDAO studentDAO = new StudentDAO();
        Student student = studentDAO.getStudentById(studentId);
        String popupStatus = "error";

        if (student != null) {
            student.setStudent_name(studentName);
            student.setStudent_email(studentEmail);
            student.setStudent_phonenum(studentPhone);
            student.setStudent_course(studentCourse);
            student.setStudent_faculty(studentFaculty);

            if (newPassword != null && !newPassword.trim().isEmpty()) {
                student.setStudent_password(newPassword);
            } else {
                student.setStudent_password(studentDAO.getStudentById(studentId).getStudent_password());
            }

            studentDAO.updateStudent(student);
            popupStatus = "success";
            request.getSession().setAttribute("studentName", studentName);
        }
        response.sendRedirect(request.getContextPath() + "/student/account?update=" + popupStatus);
    }

    /**
     * Handles displaying details of a specific event (activity) for students.
     */
    private void showEventDetails(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, ServletException, IOException {
        int activityId = Integer.parseInt(request.getParameter("activity_id"));
        ActivityDAO activityDAO = new ActivityDAO();
        Activity activity = activityDAO.getActivityDetails(activityId);

        if (activity != null) {
            boolean isRegistered = new dao.RegistrationDAO().isStudentRegisteredForActivity(studentId, activityId);
            activity.setRegistered(isRegistered);
        }
        
        request.setAttribute("activity", activity);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/studentEventDetails.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Handles displaying a student's history of registered activities.
     */
    private void showActivityHistory(HttpServletRequest request, HttpServletResponse response, String studentId) throws SQLException, ServletException, IOException {
        ActivityDAO activityDAO = new ActivityDAO();
        List<Activity> registeredActivities = activityDAO.getRegisteredActivitiesByStudent(studentId);
        
        request.setAttribute("registeredActivities", registeredActivities);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/studentActivityHistory.jsp");
        dispatcher.forward(request, response);
    }
}
