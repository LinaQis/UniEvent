package dao;

import model.MeritEntry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MeritDAO {

    /**
     * Maps a row from a ResultSet to a MeritEntry object.
     * @param rs The ResultSet to map.
     * @return A MeritEntry object.
     * @throws SQLException If a database access error occurs.
     */
    private MeritEntry mapResultSetToMeritEntry(ResultSet rs) throws SQLException {
        MeritEntry meritEntry = new MeritEntry();
        meritEntry.setMerit_entry_id(rs.getInt("merit_entry_id"));
        meritEntry.setStudent_no(rs.getString("student_no"));
        meritEntry.setActivity_id(rs.getInt("activity_id"));
        meritEntry.setMerit_points(rs.getInt("merit_points"));
        meritEntry.setRemarks(rs.getString("remarks"));
        meritEntry.setMerit_date(rs.getTimestamp("merit_date"));
        
        // Joined column (check if column exists)
        try {
            if (rs.findColumn("activity_name") > 0) {
                meritEntry.setActivity_name(rs.getString("activity_name"));
            }
        } catch (SQLException e) { /* Ignore if column not found */ }

        return meritEntry;
    }

    /**
     * Adds a new merit entry to the database.
     * Also updates the total merit score of the student in the Student table.
     * @param meritEntry The MeritEntry object to add.
     * @throws SQLException If a database access error occurs.
     */
    public void addMeritEntry(MeritEntry meritEntry) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            String sql = "INSERT INTO merit_history (student_no, activity_id, merit_points, remarks, merit_date) VALUES (?, ?, ?, ?, NOW())";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, meritEntry.getStudent_no());
                // Handle nullable activity_id
                if (meritEntry.getActivity_id() > 0) {
                    stmt.setInt(2, meritEntry.getActivity_id());
                } else {
                    stmt.setNull(2, java.sql.Types.INTEGER);
                }
                stmt.setInt(3, meritEntry.getMerit_points());
                stmt.setString(4, meritEntry.getRemarks());
                stmt.executeUpdate();
            }

            // Update student's total merit
            String updateStudentMeritSql = "UPDATE student SET student_merit = student_merit + ? WHERE student_no = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateStudentMeritSql)) {
                stmt.setInt(1, meritEntry.getMerit_points());
                stmt.setString(2, meritEntry.getStudent_no());
                stmt.executeUpdate();
            }

            conn.commit(); // Commit transaction
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback(); // Rollback on error
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true); // Reset auto-commit
                conn.close();
            }
        }
    }

    /**
     * Retrieves all merit entries for a specific student, including associated activity name.
     * @param studentNo The student's ID.
     * @return A list of MeritEntry objects.
     * @throws SQLException If a database access error occurs.
     */
    public List<MeritEntry> getMeritHistoryByStudent(String studentNo) throws SQLException {
        List<MeritEntry> meritHistory = new ArrayList<>();
        String sql = "SELECT mh.*, a.activity_name FROM merit_history mh " +
                     "LEFT JOIN activity a ON mh.activity_id = a.activity_id " +
                     "WHERE mh.student_no = ? ORDER BY mh.merit_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentNo);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    meritHistory.add(mapResultSetToMeritEntry(rs));
                }
            }
        }
        return meritHistory;
    }
}
