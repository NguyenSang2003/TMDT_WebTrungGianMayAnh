package DAO;

import database.JDBC;
import model.BookingSchedule;
import model.Order;

import java.sql.*;

public class OrderDAO {
    public int create(Order order) {
        String findOwnerSql = "SELECT user_id FROM products WHERE id = ?";
        String insertSql = "INSERT INTO orders (renter_id, owner_id, product_id, quantity, total_price, status, rent_start, rent_end, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = JDBC.getConnection()) {

            // Bước 1: Tìm owner_id từ product_id
            int ownerId = -1;
            try (PreparedStatement findStmt = connection.prepareStatement(findOwnerSql)) {
                findStmt.setInt(1, order.getProductId());
                try (ResultSet rs = findStmt.executeQuery()) {
                    if (rs.next()) {
                        ownerId = rs.getInt("user_id");
                    } else {
                        System.err.println("Không tìm thấy sản phẩm với ID: " + order.getProductId());
                        return -1;
                    }
                }
            }

            // Bước 2: Insert đơn hàng với owner_id vừa tìm
            try (PreparedStatement stmt = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, order.getRenterId());
                stmt.setInt(2, ownerId);
                stmt.setInt(3, order.getProductId());
                stmt.setInt(4, order.getQuantity());
                stmt.setDouble(5, order.getTotalPrice());
                stmt.setString(6, order.getStatus());
                stmt.setDate(7, order.getRentStart());
                stmt.setDate(8, order.getRentEnd());
                stmt.setTimestamp(9, order.getCreatedAt());
                stmt.setTimestamp(10, order.getUpdatedAt());

                int rows = stmt.executeUpdate();
                if (rows > 0) {
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            return generatedKeys.getInt(1); // ✅ Trả về order_id
                        }
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1; // ❌ Thất bại
    }

    public boolean createBooking(BookingSchedule booking) {
        String sql = "INSERT INTO booking_schedule " +
                "(product_id, renter_id, owner_id, order_id, rent_start, rent_end, status, created_at, updated_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, booking.getProductId());
            stmt.setInt(2, booking.getRenterId());
            stmt.setInt(3, booking.getOwnerId());
            if (booking.getOrderId() != null) {
                stmt.setInt(4, booking.getOrderId());
            } else {
                stmt.setNull(4, java.sql.Types.INTEGER);
            }
            stmt.setDate(5, booking.getRentStart());
            stmt.setDate(6, booking.getRentEnd());
            stmt.setString(7, booking.getStatus());
            stmt.setTimestamp(8, booking.getCreatedAt());
            stmt.setTimestamp(9, booking.getUpdatedAt());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
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
                order.setProductId(rs.getInt("product_id"));
                order.setRenterId(rs.getInt("renter_id"));
                order.setOwnerId(rs.getInt("owner_id"));
                order.setQuantity(rs.getInt("quantity"));
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

}
