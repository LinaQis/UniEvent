package models;

import java.sql.Date;
import java.sql.Time;

public class Activity {
    private int activityId;
    private int clubId;
    private String title;
    private String description;
    private Date activityDate;
    private Time startTime;
    private Time endTime;
    private String location;
    private String status;
    private String createdBy;
    private String imagePath;

    // Constructors
    public Activity() {}

    public Activity(int activityId, int clubId, String title, String description, 
                   Date activityDate, Time startTime, Time endTime, 
                   String location, String status, String createdBy, String imagePath) {
        this.activityId = activityId;
        this.clubId = clubId;
        this.title = title;
        this.description = description;
        this.activityDate = activityDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.location = location;
        this.status = status;
        this.createdBy = createdBy;
        this.imagePath = imagePath;
    }

    // Getters and Setters
    public int getActivityId() { return activityId; }
    public void setActivityId(int activityId) { this.activityId = activityId; }
    
    public int getClubId() { return clubId; }
    public void setClubId(int clubId) { this.clubId = clubId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Date getActivityDate() { return activityDate; }
    public void setActivityDate(Date activityDate) { this.activityDate = activityDate; }
    
    public Time getStartTime() { return startTime; }
    public void setStartTime(Time startTime) { this.startTime = startTime; }
    
    public Time getEndTime() { return endTime; }
    public void setEndTime(Time endTime) { this.endTime = endTime; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
    
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
}