package models;

import java.sql.Date;

public class Club {
    private int clubId;
    private String clubName;
    private String description;
    private String motto;
    private String logoPath;
    private Date createdDate;
    private String status;

    // Constructors
    public Club() {}

    public Club(int clubId, String clubName, String description, String motto, 
               String logoPath, Date createdDate, String status) {
        this.clubId = clubId;
        this.clubName = clubName;
        this.description = description;
        this.motto = motto;
        this.logoPath = logoPath;
        this.createdDate = createdDate;
        this.status = status;
    }

    // Getters and Setters
    public int getClubId() { return clubId; }
    public void setClubId(int clubId) { this.clubId = clubId; }
    
    public String getClubName() { return clubName; }
    public void setClubName(String clubName) { this.clubName = clubName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getMotto() { return motto; }
    public void setMotto(String motto) { this.motto = motto; }
    
    public String getLogoPath() { return logoPath; }
    public void setLogoPath(String logoPath) { this.logoPath = logoPath; }
    
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}