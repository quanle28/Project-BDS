package com.javaweb.model.dto;

public class CustomerDTO extends AbstractDTO{
    private String fullname;
    private String phone;
    private String email;
    private Long staffId;

    public Long getStaffId() {return staffId;}

    public void setStaffId(Long staffId) {this.staffId = staffId;}

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

}
