package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.sql.Date;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String address;
    private String role;
    private String status;
    private String userName;
    private String password;
    private Date createDate;
    private String verifyToken;
    private boolean isVerified;
    private String avatar;
    private String gender;
    private Date birthday;
    private Date tokenExpiry;
    private String oauthProvider;

    public User() {
    }

    public User(int id, String fullName, String email, String phoneNumber, String address, String role, String status, String userName, String password, Date createDate, String verifyToken, boolean isVerified, String avatar, String gender, Date birthday, Date tokenExpiry, String oauthProvider) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.role = role;
        this.status = status;
        this.userName = userName;
        this.password = password;
        this.createDate = createDate;
        this.verifyToken = verifyToken;
        this.isVerified = isVerified;
        this.avatar = avatar;
        this.gender = gender;
        this.birthday = birthday;
        this.tokenExpiry = tokenExpiry;
        this.oauthProvider = oauthProvider;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getVerifyToken() {return verifyToken; }

    public void setVerifyToken(String verifyToken) {this.verifyToken = verifyToken; }

    public boolean isVerified() {return isVerified; }

    public void setVerified(boolean verified) {isVerified = verified; }

    public String getAvatar() { return avatar; }

    public void setAvatar(String avatar) { this.avatar = avatar; }

    public String getGender() { return gender;}

    public void setGender(String gender) { this.gender = gender; }


    public Date getBirthday() { return birthday; }

    public void setBirthday(Date birthday) { this.birthday = birthday; }

    public Date getTokenExpiry() {
        return tokenExpiry;
    }

    public void setTokenExpiry(Date tokenExpiry) {
        this.tokenExpiry = tokenExpiry;
    }

    public String getOauthProvider() {
        return oauthProvider;
    }

    public void setOauthProvider(String oauthProvider) {
        this.oauthProvider = oauthProvider;
    }
}
