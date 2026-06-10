package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Cart {

    // dùng map để lưu các sp trong giỏ hàng. key = productId, value là 1 sp
    private Map<Integer, CartItem> items = new HashMap<>();

    public void add(Product product) {
        CartItem item = items.get(product.getId());
        if (item == null) {
            items.put(product.getId(), new CartItem(product, 1));
        } else {
            item.setQuantity(item.getQuantity() + 1);
        }
    }

    public void update(int productId, int quantity) {
        if (items.containsKey(productId)) {
            if (quantity <= 0) {
                items.remove(productId);
            } else {
                items.get(productId).setQuantity(quantity);
            }
        }
    }

    public void remove(int productId) {
        items.remove(productId);
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }


    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }

    //hàm lấy ra tất cả số lượng sp thêm vào giỏ hàng
    public int getTotalQuantity() {
        int total = 0;
        for (CartItem item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

}
