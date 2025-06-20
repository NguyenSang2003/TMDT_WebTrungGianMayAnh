package DAO;

import database.JDBC;
import model.BookingSchedule;

import java.sql.*;

public class BookingScheduleDAO {
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

    // getBookingsByProductId, cancelBooking, updateStatus, checkAvailability, ...
}