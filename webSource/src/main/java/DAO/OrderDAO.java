package DAO;

import database.JDBC;
import model.BookingSchedule;
import model.Order;
import model.OrderItems;
import model.OrderListView;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int create(Order order) {
        String insertSql = "INSERT INTO orders (renter_id, owner_id, total_price, status, rent_start, rent_end, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = JDBC.getConnection()) {

            try (PreparedStatement stmt = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, order.getRenterId());
                stmt.setInt(2, order.getOwnerId());
                stmt.setDouble(3, order.getTotalPrice());
                stmt.setString(4, order.getStatus());
                stmt.setDate(5, order.getRentStart());
                stmt.setDate(6, order.getRentEnd());
                stmt.setTimestamp(7, order.getCreatedAt());
                stmt.setTimestamp(8, order.getUpdatedAt());

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            return generatedKeys.getInt(1); // Trả về order_id
                        }
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1; // Thất bại
    }

    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setId(rs.getInt("id"));
                order.setRenterId(rs.getInt("renter_id"));
                order.setOwnerId(rs.getInt("owner_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setRentStart(rs.getDate("rent_start"));
                order.setRentEnd(rs.getDate("rent_end"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    public List<OrderItems> getOrderItemsByOrderId(int orderId) {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE renter_id = ? OR owner_id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setRenterId(rs.getInt("renter_id"));
                order.setOwnerId(rs.getInt("owner_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setRentStart(rs.getDate("rent_start"));
                order.setRentEnd(rs.getDate("rent_end"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setUpdatedAt(rs.getTimestamp("updated_at"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean updateOrderStatus(Order order) {
        String sql = "UPDATE orders SET status = ?, updated_at = ? WHERE id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, order.getStatus());
            stmt.setTimestamp(2, order.getUpdatedAt());
            stmt.setInt(3, order.getId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // Lấy danh sách đơn hàng theo owner_id
    public List<OrderListView> getOrdersByOwnerId(int ownerId) {
        List<OrderListView> list = new ArrayList<>();
        String sql = "SELECT o.id, u.username AS renterName, o.total_price, o.rent_start, o.rent_end, o.status, o.created_at " +
                "FROM orders o JOIN users u ON o.renter_id = u.id " +
                "WHERE o.owner_id = ? ORDER BY o.created_at DESC";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderListView order = new OrderListView();
                order.setId(rs.getInt("id"));
                order.setRenterName(rs.getString("renterName"));
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setRentStart(rs.getDate("rent_start"));  // Bổ sung lấy ngày bắt đầu
                order.setRentEnd(rs.getDate("rent_end"));      // Bổ sung lấy ngày kết thúc
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // Cập nhật trạng thái đơn hàng có điều kiện
    public boolean updateOrderStatus(int orderId, String newStatus, int ownerId) {
        String sql = "UPDATE orders SET status = ?, updated_at = ? WHERE id = ? AND owner_id = ? AND status = 'cho_duyet'";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, orderId);
            ps.setInt(4, ownerId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}