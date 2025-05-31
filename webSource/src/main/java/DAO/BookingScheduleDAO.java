package DAO;

import database.JDBC;
import model.BookingSchedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class BookingScheduleDAO {

    public List<BookingSchedule> getBookingsByProductId(int productId) {
        String sql = "SELECT * FROM booking_schedule WHERE product_id = ? AND status IN ('cho_duyet', 'xac_nhan')";
        List<BookingSchedule> bookings = new ArrayList<>();

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BookingSchedule booking = new BookingSchedule();
                booking.setId(rs.getInt("id"));
                booking.setProductId(rs.getInt("product_id"));
                booking.setRenterId(rs.getInt("renter_id"));
                booking.setOwnerId(rs.getInt("owner_id"));
                booking.setOrderId(rs.getObject("order_id") != null ? rs.getInt("order_id") : null);
                booking.setRentStart(rs.getDate("rent_start"));
                booking.setRentEnd(rs.getDate("rent_end"));
                booking.setStatus(rs.getString("status"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                booking.setUpdatedAt(rs.getTimestamp("updated_at"));
                bookings.add(booking);
            }

        } catch (SQLException ex) {
            throw new RuntimeException("Lỗi khi lấy booking theo sản phẩm: " + ex.getMessage(), ex);
        }

        return bookings;
    }
}
