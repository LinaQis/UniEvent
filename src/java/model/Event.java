package model;

public class Event {
    private String name;
    private String logoPath;
    private boolean completed;

    public Event(String name, String logoPath, boolean completed) {
        this.name = name;
        this.logoPath = logoPath;
        this.completed = completed;
    }

    public String getName() {
        return name;
    }

    public String getLogoPath() {
        return logoPath;
    }

    public boolean isCompleted() {
        return completed;
    }
}
