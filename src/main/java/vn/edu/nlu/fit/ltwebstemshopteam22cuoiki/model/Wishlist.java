package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.sql.Timestamp;

public class Wishlist {
    private int id;
    private int userId;
    private int productId;
    private Timestamp addDate;

    public Wishlist() {}

    public Wishlist(int id, int userId, int productId, Timestamp addDate) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.addDate = addDate;
    }

    public int getId() { return id; }
    public int getUserId() { return userId; }
    public int getProductId() { return productId; }
    public Timestamp getAddDate() { return addDate; }

    public void setId(int id) { this.id = id; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setProductId(int productId) { this.productId = productId; }
    public void setAddDate(Timestamp addDate) { this.addDate = addDate; }
}