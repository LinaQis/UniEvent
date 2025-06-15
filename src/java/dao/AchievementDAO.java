package dao;

import model.Achievement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AchievementDAO {

    /**
     * Maps a row from a ResultSet to an Achievement object.
     * @param rs The ResultSet to map.
     * @return An Achievement object.
     * @throws SQLException If a database access error occurs.
     */
    private Achievement mapResultSetToAchievement(ResultSet rs) throws SQLException {
        Achievement achievement = new Achievement();
        achievement.setAchievement_id(rs.getInt("achievement_id"));
        achievement.setStudent_no(rs.getString("student_no"));
        achievement.setActivity_id(rs.getInt("activity_id"));
        achievement.setTitle(rs.getString("title"));
        achievement.setDescription(rs.getString("description")); // Added
        achievement.setCert_path(rs.getString("cert_path"));
        achievement.setDate_awarded(rs.getTimestamp("date_awarded")); // Added
        return achievement;
    }

    /**
     * Retrieves all achievements for a specific student.
     * @param studentNo The student's ID.
     * @return A list of Achievement objects.
     * @throws SQLException If a database access error occurs.
     */
    public List<Achievement> getAchievementsByStudent(String studentNo) throws SQLException {
        List<Achievement> achievements = new ArrayList<>();
        // Ensure description and date_awarded columns exist in your 'achievement' table
        String sql = "SELECT achievement_id, student_no, activity_id, title, description, cert_path, date_awarded FROM achievement WHERE student_no = ? ORDER BY date_awarded DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentNo);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    achievements.add(mapResultSetToAchievement(rs));
                }
            }
        }
        return achievements;
    }

    /**
     * Adds a new achievement to the database.
     * @param achievement The Achievement object to add.
     * @throws SQLException If a database access error occurs.
     */
    public void addAchievement(Achievement achievement) throws SQLException {
        String sql = "INSERT INTO achievement (student_no, activity_id, title, description, cert_path, date_awarded) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, achievement.getStudent_no());
            stmt.setInt(2, achievement.getActivity_id());
            stmt.setString(3, achievement.getTitle());
            stmt.setString(4, achievement.getDescription());
            stmt.setString(5, achievement.getCert_path());
            stmt.setTimestamp(6, achievement.getDate_awarded());
            stmt.executeUpdate();
        }
    }
}
