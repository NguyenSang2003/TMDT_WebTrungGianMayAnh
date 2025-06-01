package DAO;

import database.JDBC;
import model.BookingSchedule;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public List<BookingSchedule> getAllBookings() {
        List<BookingSchedule> bookings = new ArrayList<>();
        Connection connection = null;

        try {
            connection = JDBC.getConnection();
            String query = "SELECT bs.*,p.name AS product_name,renter.username AS renter_name,owner.username AS owner_name FROM booking_schedule bs JOIN products p ON bs.product_id = p.id JOIN users renter ON bs.renter_id = renter.id JOIN users owner ON bs.owner_id = owner.id ORDER BY bs.created_at DESC ";

            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BookingSchedule b = new BookingSchedule();
                b.setId(rs.getInt("id"));
                b.setProductId(rs.getInt("product_id"));
                b.setRenterId(rs.getInt("renter_id"));
                b.setOwnerId(rs.getInt("owner_id"));
                b.setOrderId(rs.getObject("order_id") != null ? rs.getInt("order_id") : null);
                b.setRentStart(rs.getDate("rent_start"));
                b.setRentEnd(rs.getDate("rent_end"));
                b.setStatus(rs.getString("status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setUpdatedAt(rs.getTimestamp("updated_at"));

                b.setProductName(rs.getString("product_name"));
                b.setRenterName(rs.getString("renter_name"));
                b.setOwnerName(rs.getString("owner_name"));

                bookings.add(b);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy danh sách booking: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }

        return bookings;
    }

    public boolean updateBookingStatus(int bookingId, String newStatus) {
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "UPDATE booking_schedule SET status = ?, updated_at = NOW() WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, newStatus);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi cập nhật trạng thái booking: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
    }
}
