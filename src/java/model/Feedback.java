package model;

import java.sql.Timestamp;

public class Feedback {
    private int feedback_id;
    private String student_no;
    private int activity_id;
    private int feedback_rating;
    private String feedback_comment;
    private Timestamp feedback_date;
    
    // Additional fields for display purposes (populated via JOIN in DAOs)
    private String student_name;
    private String activity_name;
    private int club_id; // Added for filtering feedback by club

    // Getters and Setters
    public String getStudent_name() { return student_name; }
    public void setStudent_name(String student_name) { this.student_name = student_name; }

    public String getActivity_name() { return activity_name; }
    public void setActivity_name(String activity_name) { this.activity_name = activity_name; }

    public int getClub_id() { return club_id; }
    public void setClub_id(int club_id) { this.club_id = club_id; }

    public int getFeedback_id() { return feedback_id; }
    public void setFeedback_id(int feedback_id) { this.feedback_id = feedback_id; }

    public String getStudent_no() { return student_no; }
    public void setStudent_no(String student_no) { this.student_no = student_no; }

    public int getActivity_id() { return activity_id; }
    public void setActivity_id(int activity_id) { this.activity_id = activity_id; }

    public int getFeedback_rating() { return feedback_rating; }
    public void setFeedback_rating(int feedback_rating) { this.feedback_rating = feedback_rating; }

    public String getFeedback_comment() { return feedback_comment; }
    public void setFeedback_comment(String feedback_comment) { this.feedback_comment = feedback_comment; }

    public Timestamp getFeedback_date() { return feedback_date; }
    public void setFeedback_date(Timestamp feedback_date) { this.feedback_date = feedback_date; }
}
