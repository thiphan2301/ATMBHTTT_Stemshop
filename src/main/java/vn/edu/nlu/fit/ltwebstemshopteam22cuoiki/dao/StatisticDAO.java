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

        // Tính xem tháng đó có bao nhiêu ngày (28, 29, 30 hay 31)
        java.time.YearMonth yearMonthObject = java.time.YearMonth.of(year, month);
        int daysInMonth = yearMonthObject.lengthOfMonth();

        // Khởi tạo mảng số ngày tương ứng với doanh thu = 0
        for (int i = 0; i < daysInMonth; i++) {
            revenues.add(0.0);
        }

        // Truyền dấu ? để thay thế tháng và năm linh hoạt
        String sql = "SELECT DAY(OrderDate) as Day, SUM(TotalAmount) as Total " +
                "FROM orders " +
                "WHERE MONTH(OrderDate) = ? AND YEAR(OrderDate) = ? " +
                "AND OrderStatus = 'CONFIRMED' " +
                "GROUP BY DAY(OrderDate)";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Gắn giá trị tháng và năm người dùng chọn vào câu SQL
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

    // 2. [MỚI] Hàm lấy thống kê trạng thái đơn hàng cho biểu đồ tròn
    public Map<String, Integer> getOrderStatusStats() {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT OrderStatus, COUNT(*) as Count " +
                     "FROM orders " +
                     "GROUP BY OrderStatus";
                     
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                String status = rs.getString("OrderStatus");
                int count = rs.getInt("Count");
                stats.put(status, count);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }
}