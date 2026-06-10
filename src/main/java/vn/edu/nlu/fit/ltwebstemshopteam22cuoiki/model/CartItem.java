package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

public class CartItem {
    private Product product;
    private int quantity;

    public CartItem(Product product, int i) {
        this.product = product;
        this.quantity = i;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    //hàm tăng số lượng sp
    public void increase() {
        quantity++;
    }
    //hàm giảm số lượng sản phẩm trog giỏ hàng
    public void decrease() {
        quantity--;
    }

    //hàm tính tổng tiền của 1 sp trong giỏ hàng

    public double getTotalPrice() {
        return product.getPrice() * quantity;
    }
}
