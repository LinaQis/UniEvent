package model;

public class Staff {
    private String hep_staffid;
    private String hep_staffname;
    private String hep_staffemail;
    private String hep_staffphonenum;
    private String hep_staffpassword;
    private boolean hep_staffadminstatus; // Indicates if they have admin privileges
    private String staff_role; // Added for general role (e.g., "Staff", "Admin")

    // Getters and Setters
    public String getHep_staffid() { return hep_staffid; }
    public void setHep_staffid(String hep_staffid) { this.hep_staffid = hep_staffid; }

    public String getHep_staffname() { return hep_staffname; }
    public void setHep_staffname(String hep_staffname) { this.hep_staffname = hep_staffname; }

    public String getHep_staffemail() { return hep_staffemail; }
    public void setHep_staffemail(String hep_staffemail) { this.hep_staffemail = hep_staffemail; }

    public String getHep_staffphonenum() { return hep_staffphonenum; }
    public void setHep_staffphonenum(String hep_staffphonenum) { this.hep_staffphonenum = hep_staffphonenum; }

    public String getHep_staffpassword() { return hep_staffpassword; }
    public void setHep_staffpassword(String hep_staffpassword) { this.hep_staffpassword = hep_staffpassword; }

    public boolean isHep_staffadminstatus() { return hep_staffadminstatus; }
    public void setHep_staffadminstatus(boolean hep_staffadminstatus) { this.hep_staffadminstatus = hep_staffadminstatus; }

    public String getStaff_role() { return staff_role; } // Getter for staff_role
    public void setStaff_role(String staff_role) { this.staff_role = staff_role; } // Setter for staff_role
}
