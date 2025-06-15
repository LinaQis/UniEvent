package controller;

import dao.ActivityDAO;
import model.Activity;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ActivityProposalServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ActivityProposalServlet extends HttpServlet {
    
    // **FIX:** Using the exact absolute path you requested.
    private static final String ABSOLUTE_SAVE_PATH = "C:/Users/ayopc/Documents/NetBeansProjects/UniEvent/web/uploads";
    
    // The relative path stored in the database remains the same.
    private static final String DATABASE_SAVE_DIR = "uploads"; 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || !"Club Organizer".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=sessionExpired");
            return;
        }

        String redirectURL = request.getContextPath() + "/club/activities?popup=success";

        try {
            // Use the absolute path for saving files.
            File fileSaveDir = new File(ABSOLUTE_SAVE_PATH);
            if (!fileSaveDir.exists()) {
                if (!fileSaveDir.mkdirs()) {
                    throw new IOException("Fatal Error: Could not create upload directory at " + ABSOLUTE_SAVE_PATH);
                }
            }

            String eventTitle = request.getParameter("eventTitle");
            int clubId = Integer.parseInt(request.getParameter("clubId"));
            int categoryId = Integer.parseInt(request.getParameter("category"));
            String startDateTimeStr = request.getParameter("startDateTime");
            String endDateTimeStr = request.getParameter("endDateTime");
            String venue = request.getParameter("venue");
            int participantLimit = Integer.parseInt(request.getParameter("participantLimit"));
            String objectives = request.getParameter("objectives");
            String description = request.getParameter("description");
            String targetAudience = request.getParameter("targetAudience");
            String committeeList = request.getParameter("committeeList");
            double totalBudget = Double.parseDouble(request.getParameter("totalBudget"));
            String promotionStrategy = request.getParameter("promotionStrategy");
            String organizerId = (String) session.getAttribute("username");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date startDateTime = sdf.parse(startDateTimeStr);
            Date endDateTime = sdf.parse(endDateTimeStr);
            
            // Pass the absolute path to the upload function
            String posterPath = uploadFile(request.getPart("poster"), ABSOLUTE_SAVE_PATH);
            String programFlowPath = uploadFile(request.getPart("programFlow"), ABSOLUTE_SAVE_PATH);
            String budgetPath = uploadFile(request.getPart("budgetFile"), ABSOLUTE_SAVE_PATH);

            Activity activity = new Activity();
            activity.setActivity_name(eventTitle);
            activity.setClub_id(clubId);
            activity.setCategory_id(categoryId);
            activity.setActivity_startdate(new Timestamp(startDateTime.getTime()));
            activity.setActivity_enddate(new Timestamp(endDateTime.getTime()));
            activity.setActivity_location(venue);
            activity.setParticipant_limit(participantLimit);
            activity.setActivity_objectives(objectives);
            activity.setActivity_desc(description);
            activity.setTarget_audience(targetAudience);
            activity.setCommittee_list(committeeList);
            activity.setTotal_budget(totalBudget);
            activity.setPromotion_strategy(promotionStrategy);
            activity.setOrganizerid(organizerId);
            activity.setImage_path(posterPath);
            activity.setProgram_flow_path(programFlowPath);
            activity.setBudget_path(budgetPath);
            activity.setActivity_status("PENDING");

            ActivityDAO activityDAO = new ActivityDAO();
            activityDAO.addActivity(activity);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("ERROR IN ACTIVITY PROPOSAL: " + e.getMessage());
            redirectURL = request.getContextPath() + "/club/activityProposal?popup=error";
        } finally {
            response.sendRedirect(redirectURL);
        }
    }
    
    private String uploadFile(Part part, String savePath) throws IOException {
        String fileName = extractFileName(part);
        if (fileName != null && !fileName.isEmpty()) {
            Path destinationPath = Paths.get(savePath, fileName);
            try (InputStream input = part.getInputStream()) {
                Files.copy(input, destinationPath, StandardCopyOption.REPLACE_EXISTING);
            }
            return DATABASE_SAVE_DIR + "/" + fileName;
        }
        return null;
    }

    private String extractFileName(Part part) {
        String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        return submittedFileName.replaceAll("[^a-zA-Z0-9._-]", "_");
    }
}
