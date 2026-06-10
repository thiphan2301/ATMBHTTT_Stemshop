package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.util.List;

public class Product {
    private int id;
    private int categoriesID;
    private int brandID;
    private String productName;
    private String description;
    private double price;
    private int quantity;
    private String imageUrl;
    private String brandName;
    private List<String> subImages;

    public Product(int id, int categoriesID, int brandID, String productName, String description, double price, int quantity, String imageUrl, String  brandName,  List<String> subImages) {
        this.id = id;
        this.categoriesID = categoriesID;
        this.brandID = brandID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.imageUrl = imageUrl;
        this.brandName = brandName;
        this.subImages = subImages;
    }

    public Product() {
    }

    public int getId() {
        return id;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoriesID() {
        return categoriesID;
    }

    public void setCategoriesID(int categoriesID) {
        this.categoriesID = categoriesID;
    }

    public int getBrandID() {
        return brandID;
    }

    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public List<String> getSubImages() {
        return subImages;
    }

    public void setSubImages(List<String> subImages) {
        this.subImages = subImages;
    }
}
