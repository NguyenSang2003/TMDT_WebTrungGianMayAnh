package DAO;

import database.JDBC;
import model.Order;
import java.sql.*;
import java.util.*;

public class OrderDAO {
    public List<Order> getOrdersByOwner(int ownerId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE owner_id = ? ORDER BY created_at DESC";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setRenterId(rs.getInt("renter_id"));
                o.setOwnerId(rs.getInt("owner_id"));
                o.setProductId(rs.getInt("product_id"));
                o.setQuantity(rs.getInt("quantity"));
                o.setTotalPrice(rs.getDouble("total_price"));
                o.setStatus(rs.getString("status"));
                o.setRentStart(rs.getDate("rent_start"));
                o.setRentEnd(rs.getDate("rent_end"));
                o.setCreatedAt(rs.getTimestamp("created_at"));
                o.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}

