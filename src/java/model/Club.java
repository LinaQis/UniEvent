package model;

public class Club {
    private int club_id;
    private String club_name;
    private String club_desc;
    private String club_presidentID;
    private String logo_path;
    private String club_category; // Added for club category (e.g., Sports, Academic, Arts)

    // Getters and Setters
    public int getClub_id() { return club_id; }
    public void setClub_id(int club_id) { this.club_id = club_id; }

    public String getClub_name() { return club_name; }
    public void setClub_name(String club_name) { this.club_name = club_name; }

    public String getClub_desc() { return club_desc; }
    public void setClub_desc(String club_desc) { this.club_desc = club_desc; }

    public String getClub_presidentID() { return club_presidentID; }
    public void setClub_presidentID(String club_presidentID) { this.club_presidentID = club_presidentID; }
    
    public String getLogo_path() { return logo_path; }
    public void setLogo_path(String logo_path) { this.logo_path = logo_path; }

    public String getClub_category() { return club_category; } // Getter for club_category
    public void setClub_category(String club_category) { this.club_category = club_category; } // Setter for club_category
}
