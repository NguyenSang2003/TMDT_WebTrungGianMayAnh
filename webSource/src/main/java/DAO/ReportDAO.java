package DAO;

import database.JDBC;
import model.Report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {
    public List<Report> getReportsByOwner(int ownerId) {
        List<Report> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username AS reporter_name, p.name AS product_name " +
                "FROM reports r " +
                "JOIN users u ON r.reported_by = u.id " +
                "JOIN products p ON r.product_id = p.id " +
                "WHERE p.user_id = ? ORDER BY r.created_at DESC";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Report r = new Report();
                r.setId(rs.getInt("id"));
                r.setReportedBy(rs.getInt("reported_by"));
                r.setProductId(rs.getInt("product_id"));
                r.setProductName(rs.getString("product_name"));
                r.setReporterName(rs.getString("reporter_name"));
                r.setReason(rs.getString("reason"));
                r.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}