package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminImportDAO {

    // 1. Lấy danh sách sản phẩm cho Form Nhập hàng
    public List<String[]> getAllProductsForImport() {
        List<String[]> products = new ArrayList<>();
        String sql = "SELECT ID, ProductName, Quantity FROM products";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                products.add(new String[]{
                        String.valueOf(rs.getInt("ID")),
                        rs.getString("ProductName"),
                        String.valueOf(rs.getInt("Quantity"))
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // 2. Xử lý Transaction khi Lưu Nhập hàng
    public boolean importProduct(int productId, int quantity, BigDecimal importPrice, Timestamp damagedDate, String note) {
        Connection conn = null;
        try {
            conn = ConnectionDB.getConnection();
            conn.setAutoCommit(false); // Bật Transaction

            // Bước 2.1: Lưu vào lô hàng
            String sqlBatch = "INSERT INTO product_batches (ProductID, ImportPrice, InitialQuantity, UsableQuantity, ImportDate, BatchStatus, DamagedDate, Note) VALUES (?, ?, ?, ?, NOW(), 'AVAILABLE', ?, ?)";
            PreparedStatement psBatch = conn.prepareStatement(sqlBatch, Statement.RETURN_GENERATED_KEYS);
            psBatch.setInt(1, productId);
            psBatch.setBigDecimal(2, importPrice);
            psBatch.setInt(3, quantity);
            psBatch.setInt(4, quantity);
            psBatch.setTimestamp(5, damagedDate);
            psBatch.setString(6, note);
            psBatch.executeUpdate();

            ResultSet rsKeys = psBatch.getGeneratedKeys();
            int batchId = 0;
            if (rsKeys.next()) batchId = rsKeys.getInt(1);
            psBatch.close();

            // Bước 2.2: Lưu vào lịch sử
            String sqlHistory = "INSERT INTO import_history (ProductID, BatchID, Quantity, ImportPrice, ImportDate, Note) VALUES (?, ?, ?, ?, NOW(), ?)";
            PreparedStatement psHistory = conn.prepareStatement(sqlHistory);
            psHistory.setInt(1, productId);
            psHistory.setInt(2, batchId);
            psHistory.setInt(3, quantity);
            psHistory.setBigDecimal(4, importPrice);
            psHistory.setString(5, note);
            psHistory.executeUpdate();
            psHistory.close();

            // Bước 2.3: Cộng số lượng sản phẩm tổng
            String sqlProduct = "UPDATE products SET Quantity = Quantity + ? WHERE ID = ?";
            PreparedStatement psProduct = conn.prepareStatement(sqlProduct);
            psProduct.setInt(1, quantity);
            psProduct.setInt(2, productId);
            psProduct.executeUpdate();
            psProduct.close();

            conn.commit(); // Chốt sổ thành công
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            }
            return false;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }

    // 3. Lấy danh sách sản phẩm kèm số lần nhập (Cho trang Lịch sử)
    public List<Map<String, Object>> getProductsWithImportCount() {
        List<Map<String, Object>> productList = new ArrayList<>();
        String sql = "SELECT p.ID, p.ProductName, COUNT(h.ProductID) as importCount " +
                     "FROM products p " +
                     "LEFT JOIN import_history h ON p.ID = h.ProductID " +
                     "GROUP BY p.ID, p.ProductName " +
                     "ORDER BY p.ProductName";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> p = new HashMap<>();
                p.put("id", rs.getInt("ID"));
                p.put("name", rs.getString("ProductName"));
                p.put("count", rs.getInt("importCount"));
                productList.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // 4. Lấy danh sách Lịch sử nhập (Có lọc)
    public List<Map<String, Object>> getImportHistory(String filterProductId) {
        List<Map<String, Object>> historyList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT h.*, p.ProductName FROM import_history h JOIN products p ON h.ProductID = p.ID WHERE 1=1 ");

        if (filterProductId != null && !filterProductId.isEmpty()) {
            sql.append(" AND h.ProductID = ? ");
        }
        sql.append(" ORDER BY h.ImportDate DESC");

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
             
            if (filterProductId != null && !filterProductId.isEmpty()) {
                ps.setInt(1, Integer.parseInt(filterProductId));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("productId", rs.getInt("ProductID"));
                    map.put("batchId", rs.getInt("BatchID"));
                    map.put("name", rs.getString("ProductName"));
                    map.put("qty", rs.getInt("Quantity"));
                    map.put("price", rs.getBigDecimal("ImportPrice"));
                    map.put("date", rs.getTimestamp("ImportDate"));
                    map.put("note", rs.getString("Note"));
                    historyList.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return historyList;
    }
}