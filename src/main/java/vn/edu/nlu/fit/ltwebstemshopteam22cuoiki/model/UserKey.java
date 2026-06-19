package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.sql.Timestamp;

public class UserKey {
    private int id;
    private int userId;
    private String publicKey;
    private Timestamp createdAt;
    private Timestamp revokedAt;

    public UserKey(){}

    public UserKey(int id, int userId, String publicKey) {
        this.id = id;
        this.userId = userId;
        this.publicKey = publicKey;
    }

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

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getRevokedAt() {
        return revokedAt;
    }

    public void setRevokedAt(Timestamp revokedAt) {
        this.revokedAt = revokedAt;
    }
}
