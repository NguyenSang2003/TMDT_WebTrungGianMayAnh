package DAO;

import database.JDBC;
import model.RevenueReportView;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RevenueDAO {

    public List<RevenueReportView> getRevenueByOwnerAndTime(int ownerId, Date start, Date end) {
        List<RevenueReportView> list = new ArrayList<>();
        String sql = "SELECT p.id AS productId, p.name AS productName, " +
                "SUM(oi.total_price) AS totalRevenue, " +
                "SUM(oi.quantity) AS totalQuantity, " +
                "MAX(o.rent_start) AS rentDate " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.id " +
                "JOIN orders o ON oi.order_id = o.id " +
                "JOIN invoices i ON i.order_id = o.id " +
                "WHERE o.owner_id = ? " +
                "AND o.status = 'hoan_thanh' " +
                "AND i.payment_status = 'paid' " +
                "AND i.invoice_date BETWEEN ? AND ? " +
                "GROUP BY p.id, p.name";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ps.setDate(2, start);
            ps.setDate(3, end);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RevenueReportView view = new RevenueReportView();
                view.setProductId(rs.getInt("productId"));
                view.setProductName(rs.getString("productName"));
                view.setTotalRevenue(rs.getBigDecimal("totalRevenue"));
                view.setQuantity(rs.getInt("totalQuantity"));
                view.setRentDate(rs.getDate("rentDate"));
                list.add(view);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public java.math.BigDecimal getTotalRevenue(int ownerId, Date start, Date end) {
        String sql = "SELECT SUM(oi.total_price) AS totalRevenue " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.order_id = o.id " +
                "JOIN invoices i ON o.id = i.order_id " +
                "WHERE o.owner_id = ? " +
                "AND o.status = 'hoan_thanh' " +
                "AND i.payment_status = 'paid' " +
                "AND i.invoice_date BETWEEN ? AND ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ps.setDate(2, start);
            ps.setDate(3, end);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("totalRevenue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return java.math.BigDecimal.ZERO;
    }
}
