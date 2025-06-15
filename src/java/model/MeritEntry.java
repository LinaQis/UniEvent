package model;

import java.sql.Timestamp;

public class MeritEntry {
    private int merit_entry_id;
    private String student_no;
    private int activity_id; // Associated activity (optional, if merit from activity)
    private String activity_name; // For display in JSP (populated via JOIN)
    private int merit_points;
    private String remarks;
    private Timestamp merit_date;

    // Getters and Setters
    public int getMerit_entry_id() { return merit_entry_id; }
    public void setMerit_entry_id(int merit_entry_id) { this.merit_entry_id = merit_entry_id; }

    public String getStudent_no() { return student_no; }
    public void setStudent_no(String student_no) { this.student_no = student_no; }

    public int getActivity_id() { return activity_id; }
    public void setActivity_id(int activity_id) { this.activity_id = activity_id; }

    public String getActivity_name() { return activity_name; }
    public void setActivity_name(String activity_name) { this.activity_name = activity_name; }

    public int getMerit_points() { return merit_points; }
    public void setMerit_points(int merit_points) { this.merit_points = merit_points; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }

    public Timestamp getMerit_date() { return merit_date; }
    public void setMerit_date(Timestamp merit_date) { this.merit_date = merit_date; }
}
