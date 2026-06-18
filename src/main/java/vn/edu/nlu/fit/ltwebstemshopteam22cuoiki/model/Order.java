package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList; // Bổ sung import này
import java.util.HashMap;
import java.util.List;      // Bổ sung import này
import java.util.Map;

public class Order {
    private int id;
    private int userId;
    private Integer promotionId;
    private Timestamp orderDate;
    private String orderStatus;
    private double shippingFee;
    private double totalAmount;
    private String note;
    private String shippingAddress;
    private String receiverName;
    private String receiverPhone;
    private Integer paymentMethodId;
    private String paymentStatus;
    private String transactionId;
    private Date paymentTime;
    private Map<String, Double> appliedPromotions = new HashMap<>(); // lưu tên mã giảm giá và số toeefn giảm tương ứng
    private int districtId;
    private String wardCode;

    // Thuộc tính phục vụ Admin View
    private String userFullName;
    private String userPhone;

    // Danh sách sản phẩm của đơn hàng (Đã gom nhóm)
    private List<OrderItem> items = new ArrayList<>();

    public Order() {
    }

    public Order(int id, int userId, Integer promotionId, Timestamp orderDate, String orderStatus, double shippingFee, double totalAmount, String note, String shippingAddress, String receiverName, String receiverPhone, Integer paymentMethodId, String paymentStatus, String transactionId, Date paymentTime, String userFullName, String userPhone, List<OrderItem> items, Map<String, Double> appliedPromotions, int districtId, String wardCode) {
        this.id = id;
        this.userId = userId;
        this.promotionId = promotionId;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.shippingFee = shippingFee;
        this.totalAmount = totalAmount;
        this.note = note;
        this.shippingAddress = shippingAddress;
        this.receiverName = receiverName;
        this.receiverPhone = receiverPhone;
        this.paymentMethodId = paymentMethodId;
        this.paymentStatus = paymentStatus;
        this.transactionId = transactionId;
        this.paymentTime = paymentTime;
        this.userFullName = userFullName;
        this.userPhone = userPhone;
        this.items = items;
        this.appliedPromotions = appliedPromotions;
        this.districtId = districtId;
        this.wardCode = wardCode;
    }

    // Getter và Setter cho danh sách sản phẩm
    public List<OrderItem> getItems() {
        return items;
    }
    public void setItems(List<OrderItem> items) {
        this.items = items;
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

    public Integer getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(Integer promotionId) {
        this.promotionId = promotionId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public Integer getPaymentMethodId() {
        return paymentMethodId;
    }

    public void setPaymentMethodId(Integer paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public Map<String, Double> getAppliedPromotions() {
        return appliedPromotions;
    }

    public void setAppliedPromotions(Map<String, Double> appliedPromotions) {
        this.appliedPromotions = appliedPromotions;
    }

    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    public String getWardCode() {
        return wardCode;
    }

    public void setWardCode(String wardCode) {
        this.wardCode = wardCode;
    }
}