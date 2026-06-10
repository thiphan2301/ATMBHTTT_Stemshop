package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PaymentDAO {

    public static void insert(int orderId, String method, double amount) {
        String sql = "INSERT INTO payments (OrderID, Method, Amount, Status) VALUES (?, ?, ?, ?)";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ps.setString(2, method);
            ps.setDouble(3, amount);
            ps.setString(4, "PAID");

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}