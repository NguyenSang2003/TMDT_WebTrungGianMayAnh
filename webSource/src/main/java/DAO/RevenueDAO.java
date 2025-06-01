package DAO;

import database.JDBC;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class RevenueDAO {
    public Map<String, Double> getRevenueByProduct(int ownerId) {
        Map<String, Double> revenueMap = new LinkedHashMap<>();
        String sql = "SELECT p.name, SUM(o.total_price) AS revenue FROM orders o " +
                "JOIN products p ON o.product_id = p.id " +
                "WHERE o.owner_id = ? AND o.status = 'hoan_thanh' " +
                "GROUP BY p.name ORDER BY revenue DESC";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                revenueMap.put(rs.getString("name"), rs.getDouble("revenue"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueMap;
    }
}
