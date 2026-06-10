package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

public class OrderItem {
    private int productId;
    private String productName;
    private String imageUrl;
    private int quantity;
    private double price;

    // Tạo Constructor không tham số, có tham số và Getter/Setter đầy đủ
    public OrderItem() {}
    public OrderItem(int productId, String productName, String imageUrl, int quantity, double price) {
        this.productId = productId;
        this.productName = productName;
        this.imageUrl = imageUrl;
        this.quantity = quantity;
        this.price = price;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}