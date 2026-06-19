package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.OrderChangeHistory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderChangeHistoryDAO {

    public List<OrderChangeHistory> getAllHistory() {
        List<OrderChangeHistory> histories = new ArrayList<>();

        try (Connection con = ConnectionDB.getConnection()) {
            boolean hasChangedBy = hasColumn(con, "ChangedBy");
            boolean hasChangedByName = hasColumn(con, "ChangedByName");
            boolean hasSource = hasColumn(con, "Source");
            String sql = "SELECT ID, OrderID, FieldName, OldValue, NewValue, " +
                    (hasChangedBy ? "ChangedBy" : "NULL AS ChangedBy") + ", " +
                    (hasChangedByName ? "ChangedByName" : "NULL AS ChangedByName") + ", " +
                    (hasSource ? "Source" : "NULL AS Source") + ", ChangedAt, " +
                    "DATE_FORMAT(ChangedAt, '%d/%m/%Y %H:%i:%s') AS ChangedAtText " +
                    "FROM order_change_history ORDER BY ChangedAt DESC, ID DESC";

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    histories.add(mapHistory(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return histories;
    }

    private boolean hasColumn(Connection con, String columnName) {
        String sql = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS " +
                "WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'order_change_history' AND COLUMN_NAME = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, columnName);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private OrderChangeHistory mapHistory(ResultSet rs) throws Exception {
        OrderChangeHistory history = new OrderChangeHistory();
        history.setId(rs.getInt("ID"));
        history.setOrderId(rs.getInt("OrderID"));
        history.setFieldName(rs.getString("FieldName"));
        history.setOldValue(rs.getString("OldValue"));
        history.setNewValue(rs.getString("NewValue"));

        int changedBy = rs.getInt("ChangedBy");
        if (!rs.wasNull()) {
            history.setChangedBy(changedBy);
        }

        history.setChangedByName(rs.getString("ChangedByName"));
        history.setSource(rs.getString("Source"));
        history.setChangedAt(rs.getTimestamp("ChangedAt"));
        history.setChangedAtText(rs.getString("ChangedAtText"));
        return history;
    }
}
