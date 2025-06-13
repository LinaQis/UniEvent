package model;

public class Achievement {
    private String title;
    private int certId;

    public Achievement(String title, int certId) {
        this.title = title;
        this.certId = certId;
    }

    public String getTitle() {
        return title;
    }

    public int getCertId() {
        return certId;
    }
}
