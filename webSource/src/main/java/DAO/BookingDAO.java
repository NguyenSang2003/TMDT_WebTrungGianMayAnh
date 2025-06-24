package DAO;

import database.JDBC;
import model.BookingView;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public List<BookingView> getBookingViewsByOwnerId(int ownerId) {
        List<BookingView> list = new ArrayList<>();
        String sql = "SELECT b.id, p.name AS product_name, u.username AS renter_name, " +
                "b.rent_start, b.rent_end, b.status " +
                "FROM booking_schedule b " +
                "JOIN products p ON b.product_id = p.id " +
                "JOIN users u ON b.renter_id = u.id " +
                "WHERE b.owner_id = ? " +
                "ORDER BY b.created_at DESC";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BookingView b = new BookingView();
                b.setId(rs.getInt("id"));
                b.setProductName(rs.getString("product_name"));
                b.setRenterName(rs.getString("renter_name"));
                b.setRentStart(rs.getDate("rent_start"));
                b.setRentEnd(rs.getDate("rent_end"));
                b.setStatus(rs.getString("status"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateStatus(int bookingId, String newStatus, int ownerId) {
        String sql = "UPDATE booking_schedule SET status = ?, updated_at = ? WHERE id = ? AND owner_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            ps.setInt(3, bookingId);
            ps.setInt(4, ownerId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBooking(int bookingId, int ownerId) {
        String sql = "DELETE FROM booking_schedule WHERE id = ? AND owner_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.setInt(2, ownerId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
