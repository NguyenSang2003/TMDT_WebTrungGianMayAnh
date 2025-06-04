package DAO;

import database.JDBC;
import model.OrderItems;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrderItemsDAO {

    public boolean createOrderItem(OrderItems item) {
        String sql = "INSERT INTO order_items (order_id, product_id, owner_id, quantity, price_per_day, rent_start, rent_end, total_price) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, item.getOrderId());
            stmt.setInt(2, item.getProductId());
            stmt.setInt(3, item.getOwnerId());
            stmt.setInt(4, item.getQuantity());
            stmt.setDouble(5, item.getPricePerDay());
            stmt.setDate(6, item.getRentStart());
            stmt.setDate(7, item.getRentEnd());
            stmt.setDouble(8, item.getTotalPrice());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}