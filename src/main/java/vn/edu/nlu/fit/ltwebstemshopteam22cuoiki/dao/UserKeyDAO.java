package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.UserKey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserKeyDAO {

    public String getPublicKey(int userId) {
        String sql = "SELECT public_key FROM user_keys WHERE user_id = ? AND key_revoked_at IS NULL";
        Connection conn;
        PreparedStatement ps;
        ResultSet rs;
        try {
            conn = ConnectionDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("public_key");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    //Hàm kiểm tra xem user có khóa nào đang hoạt động không (để chặn thêm mới)
    public boolean hasActiveKey(int userId) {
        String sql = "SELECT COUNT(*) FROM user_keys WHERE user_id = ? AND key_revoked_at IS NULL";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //Hàm chèn khóa mới
    public boolean insertNewKey(int userId, String newPublicKey) throws Exception {
        String sql = "INSERT INTO user_keys (user_id, public_key, key_created_at, key_revoked_at) VALUES (?, ?, CURRENT_TIMESTAMP, NULL)";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, newPublicKey);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //Hàm thu hồi khóa hiện tại
    public boolean revokeActiveKey(int userId) throws Exception {
        String sql = "UPDATE user_keys SET key_revoked_at = CURRENT_TIMESTAMP WHERE user_id = ? AND key_revoked_at IS NULL";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<UserKey> getKeyHistoryByUserId(int userId) {
        List<UserKey> list = new ArrayList<>();
        String sql = "SELECT * FROM user_keys WHERE user_id = ? ORDER BY key_created_at DESC";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setInt(1, userId);
             ResultSet rs = ps.executeQuery();
             while (rs.next()) {
                list.add(new UserKey(rs.getInt("id"),
                                     rs.getInt("user_id"),
                                     rs.getString("public_key"),
                                     rs.getTimestamp("key_created_at"),
                                     rs.getTimestamp("key_revoked_at")));
             }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}
