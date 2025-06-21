package DAO;

import database.JDBC;
import model.BookingView;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

// DAO cho chức năng booking của owner
public class BookingDAO {

    // Lấy danh sách đặt thuê cho ownerId dùng trong bookingManagement.jsp
    public List<BookingView> getBookingViewByOwnerId(int ownerId) {
        List<BookingView> list = new ArrayList<>();
        String sql = "SELECT b.id, p.name AS product_name, u.username AS renter_name, " +
                "b.rent_start, b.rent_end, b.status " +
                "FROM booking_schedule b " +
                "JOIN products p ON b.product_id = p.id " +
                "JOIN users u ON b.renter_id = u.id " +
                "WHERE b.owner_id = ? " +
                "ORDER BY b.rent_start DESC";

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
}
