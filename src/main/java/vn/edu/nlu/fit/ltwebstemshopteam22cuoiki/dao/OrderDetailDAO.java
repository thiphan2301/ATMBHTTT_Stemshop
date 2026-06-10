package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.CartItem;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.OrderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class OrderDetailDAO {
    public void insert(OrderDetail detail) throws Exception {

        String sql = "INSERT INTO order_detail (OrderID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getProductId());
            ps.setInt(3, detail.getQuantity());
            ps.setDouble(4, detail.getPrice());

            ps.executeUpdate();
        }
    }
}
