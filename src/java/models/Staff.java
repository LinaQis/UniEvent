package models;

public class Staff {
    private String staffId;
    private String name;
    private String email;
    private String phoneNum;
    private String password;
    private String role;

    // Constructors
    public Staff() {}

    public Staff(String staffId, String name, String email, String phoneNum, String password, String role) {
        this.staffId = staffId;
        this.name = name;
        this.email = email;
        this.phoneNum = phoneNum;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    public String getStaffId() { return staffId; }
    public void setStaffId(String staffId) { this.staffId = staffId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhoneNum() { return phoneNum; }
    public void setPhoneNum(String phoneNum) { this.phoneNum = phoneNum; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}