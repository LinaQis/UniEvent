package dao;

import model.Club;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ClubDAO {
    
    /**
     * Maps a row from a ResultSet to a Club object.
     * @param rs The ResultSet to map.
     * @return A Club object.
     * @throws SQLException If a database access error occurs.
     */
    private Club mapResultSetToClub(ResultSet rs) throws SQLException {
        Club club = new Club();
        club.setClub_id(rs.getInt("club_id"));
        club.setClub_name(rs.getString("club_name"));
        club.setClub_desc(rs.getString("club_desc"));
        club.setClub_presidentID(rs.getString("club_presidentID"));
        club.setLogo_path(rs.getString("logo_path"));
        // Ensure 'club_category' column exists in your 'club' table
        try {
            if (rs.findColumn("club_category") > 0) {
                club.setClub_category(rs.getString("club_category"));
            }
        } catch (SQLException e) {
            // Column not found, ignore (for queries that don't select it)
        }
        return club;
    }

    /**
     * Retrieves all clubs from the database.
     * @return A list of all Club objects.
     * @throws SQLException If a database access error occurs.
     */
    public List<Club> getAllClubs() throws SQLException {
        List<Club> clubs = new ArrayList<>();
        // Assuming club_category is part of the club table
        String sql = "SELECT club_id, club_name, club_desc, club_presidentID, logo_path, club_category FROM club ORDER BY club_name ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                clubs.add(mapResultSetToClub(rs));
            }
        }
        return clubs;
    }
    
    /**
     * Retrieves clubs that a specific student has joined (simplified: registered for any activity of that club).
     * This method assumes 'registration' table links students to activities and 'activity' table links to clubs.
     * For a more robust club membership, consider a dedicated 'club_members' table.
     * @param studentId The ID of the student.
     * @return A list of Club objects the student is associated with.
     * @throws SQLException If a database access error occurs.
     */
    public List<Club> getJoinedClubs(String studentId) throws SQLException {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT DISTINCT c.club_id, c.club_name, c.club_desc, c.club_presidentID, c.logo_path, c.club_category FROM club c " +
                     "JOIN activity a ON c.club_id = a.club_id " +
                     "JOIN registration r ON a.activity_id = r.activity_id " +
                     "WHERE r.student_no = ? ORDER BY c.club_name ASC";
         try (Connection conn = DBConnection.getConnection();
              PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    clubs.add(mapResultSetToClub(rs));
                }
            }
        }
        return clubs;
    }
    
    /**
     * Retrieves a club by its president's student ID.
     * Used for mapping a Club Organizer to their club.
     * @param studentId The student ID of the club president.
     * @return The Club object, or null if not found.
     * @throws SQLException If a database access error occurs.
     */
     public Club getClubByPresident(String studentId) throws SQLException {
        String sql = "SELECT club_id, club_name, club_desc, club_presidentID, logo_path, club_category FROM club WHERE club_presidentID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToClub(rs);
                }
            }
        }
        return null;
    }

    /**
     * Gets the total count of clubs in the system.
     * @return The total count of clubs.
     * @throws SQLException If a database access error occurs.
     */
    public int getTotalClubsCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM club";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    /**
     * Retrieves a club by its ID.
     * @param clubId The ID of the club.
     * @return The Club object, or null if not found.
     * @throws SQLException If a database access error occurs.
     */
    public Club getClubById(int clubId) throws SQLException {
        String sql = "SELECT club_id, club_name, club_desc, club_presidentID, logo_path, club_category FROM club WHERE club_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clubId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToClub(rs);
                }
            }
        }
        return null;
    }

    /**
     * Sets a student as the president of a club.
     * This assumes the 'club_presidentID' column in the 'club' table is updated.
     * @param studentId The student ID to set as president.
     * @param clubId The ID of the club.
     * @throws SQLException If a database access error occurs.
     */
    public void setClubPresident(String studentId, int clubId) throws SQLException {
        String sql = "UPDATE club SET club_presidentID = ? WHERE club_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            stmt.setInt(2, clubId);
            stmt.executeUpdate();
        }
    }

    /**
     * Adds a new club to the database.
     * @param club The Club object to add.
     * @throws SQLException If a database access error occurs.
     */
    public void addClub(Club club) throws SQLException {
        String sql = "INSERT INTO club (club_name, club_desc, club_presidentID, logo_path, club_category) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, club.getClub_name());
            stmt.setString(2, club.getClub_desc());
            stmt.setString(3, club.getClub_presidentID());
            stmt.setString(4, club.getLogo_path());
            stmt.setString(5, club.getClub_category());
            stmt.executeUpdate();
        }
    }

    /**
     * Updates an existing club's information.
     * @param club The Club object with updated information.
     * @throws SQLException If a database access error occurs.
     */
    public void updateClub(Club club) throws SQLException {
        String sql = "UPDATE club SET club_name = ?, club_desc = ?, club_presidentID = ?, logo_path = ?, club_category = ? WHERE club_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, club.getClub_name());
            stmt.setString(2, club.getClub_desc());
            stmt.setString(3, club.getClub_presidentID());
            stmt.setString(4, club.getLogo_path());
            stmt.setString(5, club.getClub_category());
            stmt.setInt(6, club.getClub_id());
            stmt.executeUpdate();
        }
    }
}
