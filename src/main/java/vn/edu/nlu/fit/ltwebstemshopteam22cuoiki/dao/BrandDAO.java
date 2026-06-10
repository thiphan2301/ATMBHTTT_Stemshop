package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Brand;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {


     // Lấy hết tên thương hiệu


    public List<Brand> getAllBrands() {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT ID, BrandName FROM brands ORDER BY BrandName";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionDB.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Brand brand = new Brand();
                brand.setId(rs.getInt("ID"));
                brand.setBrandName(rs.getString("BrandName"));
                brands.add(brand);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return brands;
    }

    // Lấy thương hiệu theo id
    public Brand getBrandById(int id) {
        String sql = "SELECT ID, BrandName FROM brands WHERE ID = ?";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Brand brand = new Brand();
                brand.setId(rs.getInt("ID"));
                brand.setBrandName(rs.getString("BrandName"));
                return brand;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}