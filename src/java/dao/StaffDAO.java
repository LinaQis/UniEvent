package dao;

import model.Staff;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StaffDAO {

    /**
     * Maps a row from a ResultSet to a Staff object.
     * @param rs The ResultSet to map.
     * @return A Staff object.
     * @throws SQLException If a database access error occurs.
     */
    private Staff mapResultSetToStaff(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setHep_staffid(rs.getString("hep_staffid"));
        staff.setHep_staffname(rs.getString("hep_staffname"));
        staff.setHep_staffemail(rs.getString("hep_staffemail"));
        staff.setHep_staffphonenum(rs.getString("hep_staffphonenum"));
        staff.setHep_staffpassword(rs.getString("hep_staffpassword"));
        staff.setHep_staffadminstatus(rs.getBoolean("hep_staffadminstatus"));
        staff.setStaff_role(rs.getString("hep_staffrole"));
        return staff;
    }

    /**
     * Authenticates a staff member.
     * @param staffId The staff's ID.
     * @param password The staff's password.
     * @return The Staff object if credentials are valid, null otherwise.
     * @throws SQLException If a database access error occurs.
     */
    public Staff login(String staffId, String password) throws SQLException {
        String sql = "SELECT * FROM hep_staff WHERE hep_staffid = ? AND hep_staffpassword = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, staffId);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff(rs);
                }
            }
        }
        return null;
    }

    /**
     * Retrieves a staff member by their ID.
     * @param staffId The staff's ID.
     * @return The Staff object, or null if not found.
     * @throws SQLException If a database access error occurs.
     */
    public Staff getStaffById(String staffId) throws SQLException {
        String sql = "SELECT * FROM hep_staff WHERE hep_staffid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, staffId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff(rs);
                }
            }
        }
        return null;
    }

    /**
     * Adds a new staff member to the database.
     * @param staff The Staff object to add.
     * @throws SQLException If a database access error occurs.
     */
    public void addStaff(Staff staff) throws SQLException {
        String sql = "INSERT INTO hep_staff (hep_staffid, hep_staffname, hep_staffemail, hep_staffphonenum, hep_staffpassword, hep_staffadminstatus, hep_staffrole) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, staff.getHep_staffid());
            stmt.setString(2, staff.getHep_staffname());
            stmt.setString(3, staff.getHep_staffemail());
            stmt.setString(4, staff.getHep_staffphonenum());
            stmt.setString(5, staff.getHep_staffpassword());
            stmt.setBoolean(6, staff.isHep_staffadminstatus());
            stmt.setString(7, staff.getStaff_role());
            stmt.executeUpdate();
        }
    }

    /**
     * Updates an existing staff member's information.
     * @param staff The Staff object with updated information.
     * @throws SQLException If a database access error occurs.
     */
    public void updateStaff(Staff staff) throws SQLException {
        String sql = "UPDATE hep_staff SET hep_staffname = ?, hep_staffemail = ?, hep_staffphonenum = ?, hep_staffpassword = ? WHERE hep_staffid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, staff.getHep_staffname());
            stmt.setString(2, staff.getHep_staffemail());
            stmt.setString(3, staff.getHep_staffphonenum());
            stmt.setString(4, staff.getHep_staffpassword());
            stmt.setString(5, staff.getHep_staffid());
            stmt.executeUpdate();
        }
    }
}
