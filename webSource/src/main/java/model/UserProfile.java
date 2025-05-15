package model;

import java.sql.Date;
import java.sql.Timestamp;

public class UserProfile {
    private int id;
    private int userId;
    private String fullName;
    private String idCardNumber;
    private String address;
    private String phoneNumber;
    private java.sql.Date dateOfBirth;
    private String idCardImageUrl;
    private String idCardWithUserImageUrl;
    private boolean isVerifiedIdentity;
    private java.sql.Timestamp createdAt;
    private java.sql.Timestamp updatedAt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getIdCardNumber() {
        return idCardNumber;
    }

    public void setIdCardNumber(String idCardNumber) {
        this.idCardNumber = idCardNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getIdCardImageUrl() {
        return idCardImageUrl;
    }

    public void setIdCardImageUrl(String idCardImageUrl) {
        this.idCardImageUrl = idCardImageUrl;
    }

    public String getIdCardWithUserImageUrl() {
        return idCardWithUserImageUrl;
    }

    public void setIdCardWithUserImageUrl(String idCardWithUserImageUrl) {
        this.idCardWithUserImageUrl = idCardWithUserImageUrl;
    }

    public boolean isVerifiedIdentity() {
        return isVerifiedIdentity;
    }

    public void setVerifiedIdentity(boolean verifiedIdentity) {
        isVerifiedIdentity = verifiedIdentity;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}

