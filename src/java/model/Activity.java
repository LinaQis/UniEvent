// ===== FILE: model/Activity.java =====
package model;

import java.sql.Timestamp;

public class Activity {
    private int activity_id;
    private String activity_name;
    private String activity_desc;
    private String activity_objectives;
    private String activity_location;
    private Timestamp activity_startdate;
    private Timestamp activity_enddate;
    private String activity_status;
    private int participant_limit;
    private String organizerid;
    private int club_id;
    private String hepstaffid;
    private int category_id;
    private String image_path;
    private String program_flow_path;
    private String budget_path;
    private double total_budget;
    private String promotion_strategy;
    private String committee_list;
    private String target_audience;
    private String report_path;
    // [FIX] Added activity_fee to match the ERD and proposal
    private double activity_fee;

    // Transient fields (not in DB table)
    private String club_name;
    private String category_name;
    private boolean registered;

    // Getters and Setters
    public int getActivity_id() { return activity_id; }
    public void setActivity_id(int activity_id) { this.activity_id = activity_id; }
    public String getActivity_name() { return activity_name; }
    public void setActivity_name(String activity_name) { this.activity_name = activity_name; }
    public String getActivity_desc() { return activity_desc; }
    public void setActivity_desc(String activity_desc) { this.activity_desc = activity_desc; }
    public String getActivity_objectives() { return activity_objectives; }
    public void setActivity_objectives(String activity_objectives) { this.activity_objectives = activity_objectives; }
    public String getActivity_location() { return activity_location; }
    public void setActivity_location(String activity_location) { this.activity_location = activity_location; }
    public Timestamp getActivity_startdate() { return activity_startdate; }
    public void setActivity_startdate(Timestamp activity_startdate) { this.activity_startdate = activity_startdate; }
    public Timestamp getActivity_enddate() { return activity_enddate; }
    public void setActivity_enddate(Timestamp activity_enddate) { this.activity_enddate = activity_enddate; }
    public String getActivity_status() { return activity_status; }
    public void setActivity_status(String activity_status) { this.activity_status = activity_status; }
    public int getParticipant_limit() { return participant_limit; }
    public void setParticipant_limit(int participant_limit) { this.participant_limit = participant_limit; }
    public String getOrganizerid() { return organizerid; }
    public void setOrganizerid(String organizerid) { this.organizerid = organizerid; }
    public int getClub_id() { return club_id; }
    public void setClub_id(int club_id) { this.club_id = club_id; }
    public String getHepstaffid() { return hepstaffid; }
    public void setHepstaffid(String hepstaffid) { this.hepstaffid = hepstaffid; }
    public int getCategory_id() { return category_id; }
    public void setCategory_id(int category_id) { this.category_id = category_id; }
    public String getImage_path() { return image_path; }
    public void setImage_path(String image_path) { this.image_path = image_path; }
    public String getProgram_flow_path() { return program_flow_path; }
    public void setProgram_flow_path(String program_flow_path) { this.program_flow_path = program_flow_path; }
    public String getBudget_path() { return budget_path; }
    public void setBudget_path(String budget_path) { this.budget_path = budget_path; }
    public double getTotal_budget() { return total_budget; }
    public void setTotal_budget(double total_budget) { this.total_budget = total_budget; }
    public String getPromotion_strategy() { return promotion_strategy; }
    public void setPromotion_strategy(String promotion_strategy) { this.promotion_strategy = promotion_strategy; }
    public String getCommittee_list() { return committee_list; }
    public void setCommittee_list(String committee_list) { this.committee_list = committee_list; }
    public String getTarget_audience() { return target_audience; }
    public void setTarget_audience(String target_audience) { this.target_audience = target_audience; }
    public String getReport_path() { return report_path; }
    public void setReport_path(String report_path) { this.report_path = report_path; }
    public double getActivity_fee() { return activity_fee; }
    public void setActivity_fee(double activity_fee) { this.activity_fee = activity_fee; }
    public String getClub_name() { return club_name; }
    public void setClub_name(String club_name) { this.club_name = club_name; }
    public String getCategory_name() { return category_name; }
    public void setCategory_name(String category_name) { this.category_name = category_name; }
    public boolean isRegistered() { return registered; }
    public void setRegistered(boolean registered) { this.registered = registered; }

    public boolean isCompleted() {
        if (this.activity_enddate == null) return false;
        return new Timestamp(System.currentTimeMillis()).after(this.activity_enddate);
    }
}
