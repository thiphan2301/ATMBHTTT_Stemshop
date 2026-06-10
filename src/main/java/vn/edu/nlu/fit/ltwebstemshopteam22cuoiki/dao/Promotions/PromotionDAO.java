package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.Promotions;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PromotionDAO {

    //hàm lấy ra list code giảm giá
    public List<String> getCode(){
        List<String> listCode = new ArrayList<String>();
        String sql = "SELECT Code FROM promotions";
        try(Connection conn = ConnectionDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){

            while(rs.next()){
                listCode.add(rs.getString("Code"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return listCode;
    }

    // Hàm lấy ra kiểu giảm giá (percent hay amount)
    public String getDiscountType(String code) {
        String sql = "SELECT DiscountType FROM promotions WHERE Code = ?";
        String discountType = null;
        try(Connection conn = ConnectionDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, code);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    discountType = rs.getString("DiscountType");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return discountType;
    }

    //hàm lấy ra giá trị được giảm giá
    public double getDiscountValue(String code, String discountType){
        String sql = "SELECT DiscountValue FROM promotions WHERE code = ? AND DiscountType = ?";
        double  discountValue = 0;
        try(Connection conn = ConnectionDB.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql))
        {
            ps.setString(1, code);
            ps.setString(2, discountType);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    discountValue = rs.getDouble("DiscountValue");
                }
            }


        }catch(Exception e){
            e.printStackTrace();
        }
        return discountValue;
    }

    public Integer getPromotionIdByCode(String code) throws Exception {
        String sql = "SELECT id FROM promotions WHERE code = ?";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        }
        return null;
    }

}
