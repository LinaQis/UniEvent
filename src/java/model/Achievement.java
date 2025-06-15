package model;

import java.sql.Timestamp; // Import Timestamp for date_awarded

public class Achievement {
    private int achievement_id;
    private String student_no;
    private int activity_id;
    private String title;
    private String description; // Added for detailed achievement description
    private String cert_path;
    private Timestamp date_awarded; // Added for the date the achievement was awarded

    // Getters and Setters
    public int getAchievement_id() { return achievement_id; }
    public void setAchievement_id(int achievement_id) { this.achievement_id = achievement_id; }

    public String getStudent_no() { return student_no; }
    public void setStudent_no(String student_no) { this.student_no = student_no; }

    public int getActivity_id() { return activity_id; }
    public void setActivity_id(int activity_id) { this.activity_id = activity_id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; } // Getter for description
    public void setDescription(String description) { this.description = description; } // Setter for description

    public String getCert_path() { return cert_path; }
    public void setCert_path(String cert_path) { this.cert_path = cert_path; }

    public Timestamp getDate_awarded() { return date_awarded; } // Getter for date_awarded
    public void setDate_awarded(Timestamp date_awarded) { this.date_awarded = date_awarded; } // Setter for date_awarded
}
