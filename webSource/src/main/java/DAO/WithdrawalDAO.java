package DAO;

import database.JDBC;
import model.WithdrawalView;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class WithdrawalDAO {

    // Hàm tính tổng doanh thu đã nhận
    public BigDecimal getTotalPaidRevenue(int ownerId) {
        String sql = "SELECT IFNULL(SUM(oi.total_price), 0) AS totalRevenue " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.order_id = o.id " +
                "JOIN invoices i ON i.order_id = o.id " +
                "WHERE o.owner_id = ? " +
                "AND o.status = 'hoan_thanh' " +
                "AND i.payment_status = 'paid'";


        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("totalRevenue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    // Hàm lấy danh sách đơn đã thanh toán thành công để hiển thị chi tiết
    public List<WithdrawalView> getWithdrawalViewByOwnerId(int ownerId) {
        List<WithdrawalView> list = new ArrayList<>();
        String query = "SELECT " +
                "o.id AS order_id, " +
                "o.owner_id, " +
                "p.name AS product_name, " +
                "SUM(oi.quantity) AS total_quantity, " +
                "SUM(oi.total_price) AS total_amount, " +
                "i.payment_method, " +
                "i.created_at " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.order_id = o.id " +
                "JOIN invoices i ON o.id = i.order_id " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE o.owner_id = ? " +
                "AND o.status = 'hoan_thanh' " +
                "AND i.payment_status = 'paid' " +
                "GROUP BY o.id, o.owner_id, p.name, i.payment_method, i.created_at " +
                "ORDER BY i.created_at DESC";


        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                WithdrawalView w = new WithdrawalView();
                w.setOrderId(rs.getInt("order_id"));
                w.setOwnerId(rs.getInt("owner_id"));
                w.setProductName(rs.getString("product_name"));
                w.setQuantity(rs.getInt("total_quantity"));
                w.setAmount(rs.getBigDecimal("total_amount"));
                w.setPaymentMethod(rs.getString("payment_method"));
                w.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(w);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
