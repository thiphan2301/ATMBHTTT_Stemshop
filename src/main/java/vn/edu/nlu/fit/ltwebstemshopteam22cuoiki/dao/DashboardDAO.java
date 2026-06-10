package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class DashboardDAO {


     //Lấy tất cả thống kê cho dashboard

    public Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();

        stats.put("totalUsers", getTotalUsers());
        stats.put("totalProducts", getTotalProducts());
        stats.put("totalOrders", getTotalOrders());


        return stats;
    }


    //  Đếm tổng số users

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) as total FROM users";
        return executeCountQuery(sql);
    }


     // Đếm tổng số products
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) as total FROM products";
        return executeCountQuery(sql);
    }


     // Đếm tổng số order
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) as total FROM orders";
        return executeCountQuery(sql);
    }




      //Tính tổng doanh thu
    public double getTotalRevenue() {
        String sql = "SELECT SUM(TotalAmount) as total FROM orders WHERE OrderStatus = 'completed'";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (Exception e) {
            System.out.println("Lỗi getTotalRevenue:");
            e.printStackTrace();
        }

        return 0;
    }


    private int executeCountQuery(String sql) {
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (Exception e) {
            System.out.println("Lỗi executeCountQuery: " + sql);
            e.printStackTrace();
        }

        return 0;
    }
}

