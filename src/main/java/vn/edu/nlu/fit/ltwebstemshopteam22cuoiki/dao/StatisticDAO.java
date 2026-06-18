package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StatisticDAO {

    public List<Double> getRevenueByMonth(int month, int year) {
        List<Double> revenues = new ArrayList<>();

        java.time.YearMonth yearMonthObject = java.time.YearMonth.of(year, month);
        int daysInMonth = yearMonthObject.lengthOfMonth();

        for (int i = 0; i < daysInMonth; i++) {
            revenues.add(0.0);
        }

        // ĐÃ SỬA: Đổi 'CONFIRMED' thành 'DELIVERED' cho đúng với dữ liệu thực tế dưới DB của bạn
        String sql = "SELECT DAY(OrderDate) as Day, SUM(TotalAmount) as Total " +
                "FROM orders " +
                "WHERE MONTH(OrderDate) = ? AND YEAR(OrderDate) = ? " +
                "AND OrderStatus = 'DELIVERED' " +
                "GROUP BY DAY(OrderDate)";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, month);
            ps.setInt(2, year);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int day = rs.getInt("Day");
                    double total = rs.getDouble("Total");
                    revenues.set(day - 1, total);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenues;
    }

    // ĐÃ SỬA: Thêm tham số month và year để biểu đồ tròn lọc đồng bộ với biểu đồ đường
    public Map<String, Integer> getOrderStatusStats(int month, int year) {
        Map<String, Integer> stats = new HashMap<>();

        String sql = "SELECT OrderStatus, COUNT(*) as Count " +
                "FROM orders " +
                "WHERE MONTH(OrderDate) = ? AND YEAR(OrderDate) = ? " +
                "GROUP BY OrderStatus";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, month);
            ps.setInt(2, year);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String status = rs.getString("OrderStatus");
                    int count = rs.getInt("Count");
                    stats.put(status, count);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }
}