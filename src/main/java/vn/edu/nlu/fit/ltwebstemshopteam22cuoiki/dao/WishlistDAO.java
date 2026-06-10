package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    // kiểm tra sản phẩm đã được thích chưa
    public boolean exists(int userId, int productId) {
        String sql = "SELECT 1 FROM wishlists WHERE UserID=? AND ProductID=?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // thêm wishlist
    public void insert(int userId, int productId) {
        String sql = "INSERT INTO wishlists(UserID, ProductID, AddDate) VALUES (?, ?, NOW())";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // xóa wishlist
    public void delete(int userId, int productId) {
        String sql = "DELETE FROM wishlists WHERE UserID=? AND ProductID=?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // đếm số wishlist
    public int countByUser(int userId) {
        String sql = "SELECT COUNT(*) FROM wishlists WHERE UserID=?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // lấy danh sách sản phẩm yêu thích
    public List<Product> getWishlistProducts(int userId) {
        List<Product> list = new ArrayList<>();

        String sql =
                "SELECT p.ID, p.ProductName, p.Price, pi.ImageURL " +
                        "FROM wishlists w " +
                        "JOIN products p ON w.ProductID = p.ID " +
                        "LEFT JOIN product_image pi ON p.ID = pi.ProductID " +
                        "WHERE w.UserID = ? " +
                        "GROUP BY p.ID " +
                        "ORDER BY w.AddDate DESC";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getDouble("Price"));
                p.setImageUrl(rs.getString("ImageURL"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}