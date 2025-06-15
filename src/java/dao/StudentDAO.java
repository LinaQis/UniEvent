package dao;

import model.Student;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudent_no(rs.getString("student_no"));
        student.setStudent_name(rs.getString("student_name"));
        student.setStudent_email(rs.getString("student_email"));
        student.setStudent_phonenum(rs.getString("student_phonenum"));
        student.setStudent_password(rs.getString("student_password"));
        student.setStudent_course(rs.getString("student_course"));
        student.setStudent_merit(rs.getInt("student_merit"));
        student.setStudent_faculty(rs.getString("student_faculty"));
        student.setStudent_status(rs.getString("student_status"));
        return student;
    }
    
    public Student login(String studentNo, String password) throws SQLException {
        String sql = "SELECT * FROM student WHERE student_no = ? AND student_password = ? AND student_status = 'ACTIVE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentNo);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStudent(rs);
                }
            }
        }
        return null;
    }
    
     public Student getStudentById(String studentId) throws SQLException {
        String sql = "SELECT * FROM student WHERE student_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStudent(rs);
                }
            }
        }
        return null;
    }

    public void registerStudent(Student student) throws SQLException {
        String sql = "INSERT INTO student (student_no, student_name, student_email, student_phonenum, student_password, student_course, student_faculty, student_merit, student_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, student.getStudent_no());
            stmt.setString(2, student.getStudent_name());
            stmt.setString(3, student.getStudent_email());
            stmt.setString(4, student.getStudent_phonenum());
            stmt.setString(5, student.getStudent_password());
            stmt.setString(6, student.getStudent_course());
            stmt.setString(7, student.getStudent_faculty());
            stmt.setInt(8, student.getStudent_merit());
            stmt.setString(9, student.getStudent_status());
            stmt.executeUpdate();
        }
    }
    
    public void updateStudent(Student student) throws SQLException {
        String sql = "UPDATE student SET student_name = ?, student_email = ?, student_phonenum = ?, student_password = ?, student_course = ?, student_faculty = ?, student_merit = ?, student_status = ? WHERE student_no = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, student.getStudent_name());
            stmt.setString(2, student.getStudent_email());
            stmt.setString(3, student.getStudent_phonenum());
            stmt.setString(4, student.getStudent_password());
            stmt.setString(5, student.getStudent_course());
            stmt.setString(6, student.getStudent_faculty());
            stmt.setInt(7, student.getStudent_merit());
            stmt.setString(8, student.getStudent_status());
            stmt.setString(9, student.getStudent_no());
            stmt.executeUpdate();
        }
    }

    /**
     * Retrieves the newest members of a club.
     * This query is corrected to be compatible with SQL modes that enforce ONLY_FULL_GROUP_BY.
     * It finds the latest registration date for each student in the club and sorts by that date.
     */
    public List<Student> getNewMembersForClub(int clubId, int limit) throws SQLException {
        List<Student> members = new ArrayList<>();
        // --- THIS SQL QUERY IS CORRECTED ---
        String sql = "SELECT s.* FROM student s " +
                     "JOIN ( " +
                     "    SELECT r.student_no, MAX(r.registration_date) AS latest_registration " +
                     "    FROM registration r " +
                     "    JOIN activity a ON r.activity_id = a.activity_id " +
                     "    WHERE a.club_id = ? " +
                     "    GROUP BY r.student_no " +
                     ") AS latest_regs ON s.student_no = latest_regs.student_no " +
                     "ORDER BY latest_regs.latest_registration DESC LIMIT ?";
                     
         try (Connection conn = DBConnection.getConnection(); 
              PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clubId);
            stmt.setInt(2, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while(rs.next()){
                    members.add(mapResultSetToStudent(rs));
                }
            }
        }
        return members;
    }

    public List<Student> getTopStudents(int limit) throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM student WHERE student_status = 'ACTIVE' ORDER BY student_merit DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    students.add(mapResultSetToStudent(rs));
                }
            }
        }
        return students;
    }

    public List<Student> getClubMembers(int clubId) throws SQLException {
        List<Student> members = new ArrayList<>();
        String sql = "SELECT DISTINCT s.* FROM student s " +
                     "JOIN registration r ON s.student_no = r.student_no " +
                     "JOIN activity a ON r.activity_id = a.activity_id " +
                     "WHERE a.club_id = ? ORDER BY s.student_name ASC";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clubId);
            try (ResultSet rs = stmt.executeQuery()) {
                while(rs.next()){
                    members.add(mapResultSetToStudent(rs));
                }
            }
        }
        return members;
    }

    public int getTotalStudentsCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM student WHERE student_status = 'ACTIVE'";
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
