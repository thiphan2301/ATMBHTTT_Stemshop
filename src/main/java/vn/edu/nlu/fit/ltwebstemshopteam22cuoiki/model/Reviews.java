package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.sql.Timestamp;

public class Reviews {
    private int id;
    private int userID;
    private int productID;
    private double rating;
    private String comment;
    private Timestamp createDate;
    private String userName;
    private String avatar;

    public Reviews() {
    }

    public Reviews(int id, int userID, int productID, double rating, String comment, Timestamp createDate, String userName, String avatar) {
        this.id = id;
        this.userID = userID;
        this.productID = productID;
        this.rating = rating;
        this.comment = comment;
        this.createDate = createDate;
        this.userName = userName;
        this.avatar = avatar;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}