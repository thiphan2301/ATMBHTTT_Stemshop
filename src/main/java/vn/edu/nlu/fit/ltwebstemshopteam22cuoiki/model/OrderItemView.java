package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

public class OrderItemView {
    private int orderId;
    private String productName;
    private String imageUrl;
    private int quantity;
    private double price;
    private String orderStatus;

    public OrderItemView(int orderId, String productName, String imageUrl, int quantity, double price, String orderStatus) {
        this.orderId = orderId;
        this.productName = productName;
        this.imageUrl = imageUrl;
        this.quantity = quantity;
        this.price = price;
        this.orderStatus = orderStatus;
    }

    public int getOrderId() { return orderId; }
    public String getProductName() { return productName; }
    public String getImageUrl() { return imageUrl; }
    public int getQuantity() { return quantity; }
    public double getPrice() { return price; }
    public String getOrderStatus() {
        return orderStatus;
    }
}