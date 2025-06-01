package DAO;

import database.JDBC;
import model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
    public List<Comment> getAllCommentsForOwner(int ownerId) {
        List<Comment> list = new ArrayList<>();
        String sql = "SELECT c.*, u.username, p.name AS product_name FROM order_comments c " +
                "JOIN users u ON c.commenter_id = u.id " +
                "JOIN orders o ON c.order_id = o.id " +
                "JOIN products p ON o.product_id = p.id " +
                "WHERE o.owner_id = ? ORDER BY c.created_at DESC";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment c = new Comment();
                c.setId(rs.getInt("id"));
                c.setOrderId(rs.getInt("order_id"));
                c.setCommenterName(rs.getString("username"));
                c.setProductName(rs.getString("product_name"));
                c.setComment(rs.getString("comment"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
