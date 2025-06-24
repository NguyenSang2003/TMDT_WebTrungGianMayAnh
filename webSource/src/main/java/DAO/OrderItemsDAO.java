package DAO;

import database.JDBC;
import model.OrderItems;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public List<OrderItems> getItemsByOrderId(int orderId) {
        List<OrderItems> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItems item = new OrderItems();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setOwnerId(rs.getInt("owner_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPricePerDay(rs.getDouble("price_per_day"));
                item.setRentStart(rs.getDate("rent_start"));
                item.setRentEnd(rs.getDate("rent_end"));
                item.setTotalPrice(rs.getDouble("total_price"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

}