package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class RegistrationDAO {

    /**
     * Registers a student for an activity.
     * @param studentNo The student's ID.
     * @param activityId The activity's ID.
     * @throws SQLException If a database access error occurs.
     */
    public void registerStudentForActivity(String studentNo, int activityId) throws SQLException {
        String sql = "INSERT INTO registration (student_no, activity_id, registration_date) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentNo);
            stmt.setInt(2, activityId);
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stmt.executeUpdate();
        }
    }

    /**
     * Checks if a student is already registered for a specific activity.
     * @param studentNo The student's ID.
     * @param activityId The activity's ID.
     * @return true if registered, false otherwise.
     * @throws SQLException If a database access error occurs.
     */
    public boolean isStudentRegisteredForActivity(String studentNo, int activityId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM registration WHERE student_no = ? AND activity_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentNo);
            stmt.setInt(2, activityId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
}
