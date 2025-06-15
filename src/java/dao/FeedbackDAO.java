package dao;

import model.Feedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {
    
    /**
     * Maps a row from a ResultSet to a Feedback object, including joined data.
     * @param rs The ResultSet to map.
     * @return A Feedback object.
     * @throws SQLException If a database access error occurs.
     */
    private Feedback mapResultSetToFeedback(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback();
        feedback.setFeedback_id(rs.getInt("feedback_id"));
        feedback.setStudent_no(rs.getString("student_no"));
        feedback.setActivity_id(rs.getInt("activity_id"));
        feedback.setFeedback_rating(rs.getInt("feedback_rating"));
        feedback.setFeedback_comment(rs.getString("feedback_comment"));
        feedback.setFeedback_date(rs.getTimestamp("feedback_date"));
        
        // Joined columns (ensure they are selected in the SQL query)
        try {
            if (rs.findColumn("student_name") > 0) { // Check if column exists
                feedback.setStudent_name(rs.getString("student_name"));
            }
        } catch (SQLException e) { /* Ignore if column not found */ }

        try {
            if (rs.findColumn("activity_name") > 0) { // Check if column exists
                feedback.setActivity_name(rs.getString("activity_name"));
            }
        } catch (SQLException e) { /* Ignore if column not found */ }
        
        try {
            if (rs.findColumn("club_id_from_activity") > 0) { // Check if column exists (alias needed in JOIN)
                feedback.setClub_id(rs.getInt("club_id_from_activity"));
            } else if (rs.findColumn("club_id") > 0) { // Fallback if no alias used
                 feedback.setClub_id(rs.getInt("club_id"));
            }
        } catch (SQLException e) { /* Ignore if column not found */ }

        return feedback;
    }

    /**
     * Adds a new feedback entry to the database.
     * @param feedback The Feedback object to add.
     * @throws SQLException If a database access error occurs.
     */
    public void addFeedback(Feedback feedback) throws SQLException {
        String sql = "INSERT INTO feedback (student_no, activity_id, feedback_rating, feedback_comment, feedback_date) VALUES (?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, feedback.getStudent_no());
            stmt.setInt(2, feedback.getActivity_id());
            stmt.setInt(3, feedback.getFeedback_rating());
            stmt.setString(4, feedback.getFeedback_comment());
            stmt.executeUpdate();
        }
    }
    
    /**
     * Retrieves all feedback entries submitted by a specific student.
     * Joins with activity to get activity_name.
     * @param studentNo The ID of the student.
     * @return A list of Feedback objects for the student.
     * @throws SQLException If a database access error occurs.
     */
    public List<Feedback> getFeedbackByStudent(String studentNo) throws SQLException {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.*, a.activity_name FROM feedback f " +
                     "JOIN activity a ON f.activity_id = a.activity_id " +
                     "WHERE f.student_no = ? ORDER BY f.feedback_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentNo);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    feedbackList.add(mapResultSetToFeedback(rs));
                }
            }
        }
        return feedbackList;
    }

    /**
     * Retrieves all feedback entries for a specific club.
     * Joins with student and activity tables to get student name and activity name.
     * @param clubId The ID of the club.
     * @return A list of Feedback objects for the club.
     * @throws SQLException If a database access error occurs.
     */
    public List<Feedback> getFeedbackForClub(int clubId) throws SQLException {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.*, s.student_name, a.activity_name FROM feedback f " +
                     "JOIN student s ON f.student_no = s.student_no " +
                     "JOIN activity a ON f.activity_id = a.activity_id " +
                     "WHERE a.club_id = ? ORDER BY f.feedback_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clubId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    feedbackList.add(mapResultSetToFeedback(rs));
                }
            }
        }
        return feedbackList;
    }

    /**
     * Retrieves all feedback entries in the system.
     * Joins with student and activity tables to get student name, activity name, and club ID.
     * The alias `a.club_id AS club_id_from_activity` is crucial for mapping to feedback.club_id.
     * @return A list of all Feedback objects.
     * @throws SQLException If a database access error occurs.
     */
    public List<Feedback> getAllFeedbackWithStudentAndActivityDetails() throws SQLException {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.*, s.student_name, a.activity_name, a.club_id AS club_id_from_activity FROM feedback f " +
                     "JOIN student s ON f.student_no = s.student_no " +
                     "JOIN activity a ON f.activity_id = a.activity_id " +
                     "ORDER BY f.feedback_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                feedbackList.add(mapResultSetToFeedback(rs));
            }
        }
        return feedbackList;
    }
}
