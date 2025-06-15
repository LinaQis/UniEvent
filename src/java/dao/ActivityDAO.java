package dao;

import model.Activity;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO {

    private Activity mapResultSetToActivity(ResultSet rs) throws SQLException {
        Activity activity = new Activity();
        activity.setActivity_id(rs.getInt("activity_id"));
        activity.setActivity_name(rs.getString("activity_name"));
        activity.setActivity_desc(rs.getString("activity_desc"));
        activity.setActivity_location(rs.getString("activity_location"));
        activity.setActivity_startdate(rs.getTimestamp("activity_startdate"));
        activity.setActivity_enddate(rs.getTimestamp("activity_enddate"));
        activity.setActivity_status(rs.getString("activity_status"));
        // [FIX] Standardized to participant_limit from activity_participantcount
        activity.setParticipant_limit(rs.getInt("participant_limit"));
        activity.setOrganizerid(rs.getString("organizerid"));
        activity.setClub_id(rs.getInt("club_id"));
        activity.setHepstaffid(rs.getString("hepstaffid"));
        activity.setCategory_id(rs.getInt("category_id"));
        activity.setImage_path(rs.getString("image_path"));
        activity.setActivity_objectives(rs.getString("activity_objectives"));
        activity.setTarget_audience(rs.getString("target_audience"));
        activity.setCommittee_list(rs.getString("committee_list"));
        activity.setProgram_flow_path(rs.getString("program_flow_path"));
        activity.setBudget_path(rs.getString("budget_path"));
        activity.setTotal_budget(rs.getDouble("total_budget"));
        activity.setPromotion_strategy(rs.getString("promotion_strategy"));
        activity.setReport_path(rs.getString("report_path"));
        // [FIX] Added activity_fee as per ERD
        activity.setActivity_fee(rs.getDouble("activity_fee"));

        // Joined columns check
        try {
            if (rs.findColumn("club_name") > 0) {
                activity.setClub_name(rs.getString("club_name"));
            }
        } catch (SQLException e) { /* Ignore */ }
        try {
            if (rs.findColumn("category_name") > 0) {
                activity.setCategory_name(rs.getString("category_name"));
            }
        } catch (SQLException e) { /* Ignore */ }
        return activity;
    }

    public void addActivity(Activity activity) throws SQLException {
        // [FIX] Added all new fields to the INSERT statement for consistency
        String sql = "INSERT INTO activity (activity_name, activity_desc, activity_location, activity_startdate, activity_enddate, " +
                     "activity_status, participant_limit, organizerid, club_id, category_id, image_path, " +
                     "activity_objectives, target_audience, committee_list, program_flow_path, budget_path, " +
                     "total_budget, promotion_strategy, activity_fee) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, activity.getActivity_name());
            stmt.setString(2, activity.getActivity_desc());
            stmt.setString(3, activity.getActivity_location());
            stmt.setTimestamp(4, activity.getActivity_startdate());
            stmt.setTimestamp(5, activity.getActivity_enddate());
            stmt.setString(6, activity.getActivity_status());
            stmt.setInt(7, activity.getParticipant_limit());
            stmt.setString(8, activity.getOrganizerid());
            stmt.setInt(9, activity.getClub_id());
            stmt.setInt(10, activity.getCategory_id());
            stmt.setString(11, activity.getImage_path());
            stmt.setString(12, activity.getActivity_objectives());
            stmt.setString(13, activity.getTarget_audience());
            stmt.setString(14, activity.getCommittee_list());
            stmt.setString(15, activity.getProgram_flow_path());
            stmt.setString(16, activity.getBudget_path());
            stmt.setDouble(17, activity.getTotal_budget());
            stmt.setString(18, activity.getPromotion_strategy());
            // [FIX] Added activity_fee
            stmt.setDouble(19, activity.getActivity_fee());
            stmt.executeUpdate();
        }
    }

    public void updateActivityStatus(int activityId, String status, String hepStaffId) throws SQLException {
        String sql = "UPDATE activity SET activity_status = ?, hepstaffid = ? WHERE activity_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, hepStaffId);
            stmt.setInt(3, activityId);
            stmt.executeUpdate();
        }
    }

    public void updateActivityReportPath(int activityId, String reportPath) throws SQLException {
        String sql = "UPDATE activity SET report_path = ? WHERE activity_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, reportPath);
            stmt.setInt(2, activityId);
            stmt.executeUpdate();
        }
    }

    // [FIX] This join was missing category which is needed for display.
    public List<Activity> getApprovedUpcomingEvents() throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "WHERE a.activity_startdate > NOW() AND a.activity_status = 'APPROVED' ORDER BY a.activity_startdate ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                activities.add(mapResultSetToActivity(rs));
            }
        }
        return activities;
    }

    public List<Activity> getInProgressEventsByStudent(String studentId) throws SQLException {
        List<Activity> events = new ArrayList<>();
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN registration r ON a.activity_id = r.activity_id " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "WHERE r.student_no = ? AND a.activity_status = 'APPROVED' " +
                     "AND a.activity_startdate <= NOW() AND a.activity_enddate >= NOW() ORDER BY a.activity_enddate ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    events.add(mapResultSetToActivity(rs));
                }
            }
        }
        return events;
    }
    
    public List<Activity> getRegisteredActivitiesByStudent(String studentId) throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN registration r ON a.activity_id = r.activity_id " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "WHERE r.student_no = ? ORDER BY a.activity_startdate DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    activities.add(mapResultSetToActivity(rs));
                }
            }
        }
        return activities;
    }

    // [FIX] Corrected status to 'APPROVED' for completed events as per business logic
    public long getCompletedEventsCount(String studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM registration r JOIN activity a ON r.activity_id = a.activity_id WHERE r.student_no = ? AND a.activity_enddate < NOW() AND a.activity_status = 'APPROVED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        }
        return 0;
    }

    public long getTotalJoinedEventsCount(String studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM registration WHERE student_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong(1);
                }
            }
        }
        return 0;
    }
    
    public List<Activity> getActivitiesByClub(int clubId) throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "WHERE a.club_id = ? ORDER BY a.activity_startdate DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clubId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    activities.add(mapResultSetToActivity(rs));
                }
            }
        }
        return activities;
    }

    public List<Activity> getUpcomingEventsByClub(int clubId) throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "WHERE a.club_id = ? AND a.activity_startdate > NOW() ORDER BY a.activity_startdate ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clubId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    activities.add(mapResultSetToActivity(rs));
                }
            }
        }
        return activities;
    }
    
    public List<Activity> getPastEventsByClub(int clubId) throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "WHERE a.club_id = ? AND a.activity_enddate < NOW() ORDER BY a.activity_startdate DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clubId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    activities.add(mapResultSetToActivity(rs));
                }
            }
        }
        return activities;
    }

    public List<Activity> getAllActivitiesWithClubAndCategoryNames() throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "ORDER BY a.activity_startdate DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                activities.add(mapResultSetToActivity(rs));
            }
        }
        return activities;
    }

    public List<Activity> getPendingActivities() throws SQLException {
        List<Activity> activities = new ArrayList<>();
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "WHERE a.activity_status = 'PENDING' ORDER BY a.activity_startdate ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                activities.add(mapResultSetToActivity(rs));
            }
        }
        return activities;
    }
    
    public Activity getActivityDetails(int activityId) throws SQLException {
        Activity activity = null;
        String sql = "SELECT a.*, c.club_name, cat.category_name FROM activity a " +
                     "JOIN club c ON a.club_id = c.club_id " +
                     "JOIN category cat ON a.category_id = cat.category_id " +
                     "WHERE a.activity_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, activityId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    activity = mapResultSetToActivity(rs);
                }
            }
        }
        return activity;
    }

    public int getTotalActivitiesCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM activity";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // [FIX] Added method to get pending activities count for dashboard card
    public int getPendingActivitiesCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM activity WHERE activity_status = 'PENDING'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // [FIX] Added method to get approved activities count for dashboard card
    public int getApprovedActivitiesCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM activity WHERE activity_status = 'APPROVED'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}