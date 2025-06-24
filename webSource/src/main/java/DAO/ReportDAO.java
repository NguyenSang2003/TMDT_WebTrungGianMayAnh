package DAO;

import database.JDBC;
import model.ReportView;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {

    // Lấy danh sách báo cáo của sản phẩm thuộc owner đang đăng nhập
    public List<ReportView> getReportsByOwnerId(int ownerId) {
        List<ReportView> list = new ArrayList<>();
        String sql = "SELECT r.id, p.name AS productName, u.username AS reporterName, r.reason, r.created_at " +
                "FROM reports r " +
                "JOIN products p ON r.product_id = p.id " +
                "JOIN users u ON r.reported_by = u.id " +
                "WHERE p.user_id = ? " +
                "ORDER BY r.created_at DESC";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReportView report = new ReportView();
                report.setId(rs.getInt("id"));
                report.setProductName(rs.getString("productName"));
                report.setReporterName(rs.getString("reporterName"));
                report.setReason(rs.getString("reason"));
                report.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
