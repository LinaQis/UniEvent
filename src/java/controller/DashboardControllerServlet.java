package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import model.Event;
import model.Achievement;

@WebServlet("/dashboard")
public class DashboardControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String studentName = (String) session.getAttribute("studentName");
        String studentId = (String) session.getAttribute("username");

        if (studentName == null || studentId == null) {
            response.sendRedirect("login.jsp?error=sessionExpired");
            return;
        }

        List<Event> inProgressEvents = Arrays.asList(
            new Event("Blood Donation Drive", "images/event2.jpg", true),
            new Event("Tree Planting Campaign", "images/event3.jpg", false),
            new Event("Charity Fun Run", "images/event4.jpg", true)
        );

        List<Achievement> achievements = Arrays.asList(
            new Achievement("Leadership Camp Certificate", 1),
            new Achievement("Community Service Award", 2),
            new Achievement("Club Excellence Recognition", 3)
        );

        String[] topStudents = {
            "Mohd Hafidz Zafrel",
            "Mohd Hana Huzairi",
            "Nur Qaisya Alyssa"
        };

        List<String> joinedClubs = Arrays.asList(
            "images/club1.png",
            "images/club2.png",
            "images/club3.png",
            "images/club4.png",
            "images/club5.png"
        );

        request.setAttribute("studentName", studentName);
        request.setAttribute("studentId", studentId);
        request.setAttribute("inProgressEvents", inProgressEvents);
        request.setAttribute("achievements", achievements);
        request.setAttribute("topStudents", topStudents);
        request.setAttribute("meritPercentage", 50);
        request.setAttribute("joinedClubs", joinedClubs);

        RequestDispatcher dispatcher = request.getRequestDispatcher("studentDashboard.jsp");
        dispatcher.forward(request, response);
    }
}