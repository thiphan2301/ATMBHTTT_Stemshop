package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.ProductImage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductImageDAO {
    // Lấy danh sách các ảnh của 1 sp theo id
    public List<ProductImage> findByProductId (int productId){
        List<ProductImage> list = new ArrayList<ProductImage>();
        String sql = "SELECT * FROM product_image  WHERE ProductID = ? ORDER BY ID ASC";
        try (
                Connection con = ConnectionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
            ){
            ps.setInt(1,productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()){
                ProductImage img = new ProductImage(
                    rs.getInt("ID"),
                    rs.getInt("ProductID"),
                    rs.getString("ImageURL")
                );
                list.add(img);
            }

        }
        catch (Exception e){
            e.printStackTrace();
        }
        return list;
    }
    // Cập nhật hoặc thêm ảnh cho sản phẩm
    public boolean updateOrAddProductImage(int productId, String imageUrl) {
        // Kiểm tra xem đã có ảnh chưa
        String checkSql = "SELECT ID FROM product_image WHERE ProductID = ? LIMIT 1";
        String updateSql = "UPDATE product_image SET ImageURL = ? WHERE ProductID = ?";
        String insertSql = "INSERT INTO product_image (ProductID, ImageURL) VALUES (?, ?)";

        Connection con = null;
        PreparedStatement checkPs = null;
        PreparedStatement updatePs = null;
        PreparedStatement insertPs = null;
        ResultSet rs = null;

        try {
            con = ConnectionDB.getConnection();

            // Check xem đã có ảnh chưa
            checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, productId);
            rs = checkPs.executeQuery();

            if (rs.next()) {
                // Đã có ảnh -> UPDATE
                updatePs = con.prepareStatement(updateSql);
                updatePs.setString(1, imageUrl);
                updatePs.setInt(2, productId);
                return updatePs.executeUpdate() > 0;
            } else {
                // Chưa có ảnh -> INSERT
                insertPs = con.prepareStatement(insertSql);
                insertPs.setInt(1, productId);
                insertPs.setString(2, imageUrl);
                return insertPs.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //thêm ảnh
    public void insertImage(int productId, String imageUrl) {
        String sql = "INSERT INTO product_image (ProductID, ImageURL) VALUES (?, ?)";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setString(2, imageUrl);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // hàm lấy tất cả ảnh của 1 sp
    public List<String> getImagesByProductId(int productId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT ImageURL FROM product_image WHERE ProductID = ? ORDER BY ID";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                images.add(rs.getString("ImageURL"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return images;
    }

    //hàm thêm 1 ảnh mới
    public void addImage(int productId, String imageUrl) {
        String sql = "INSERT INTO product_image(ProductID, ImageURL) VALUES (?, ?)";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setString(2, imageUrl);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //xáo hết ảnh theo id
    public void deleteAllByProductId(int productId) {
        String sql = "DELETE FROM product_image WHERE ProductID = ?";
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
