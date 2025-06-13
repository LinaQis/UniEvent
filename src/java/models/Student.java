package models;

public class Student {
    private String studentId;
    private String name;
    private String email;
    private String phoneNum;
    private String password;
    private String status;

    // Constructors
    public Student() {}

    public Student(String studentId, String name, String email, String phoneNum, String password, String status) {
        this.studentId = studentId;
        this.name = name;
        this.email = email;
        this.phoneNum = phoneNum;
        this.password = password;
        this.status = status;
    }

    // Getters and Setters
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhoneNum() { return phoneNum; }
    public void setPhoneNum(String phoneNum) { this.phoneNum = phoneNum; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}