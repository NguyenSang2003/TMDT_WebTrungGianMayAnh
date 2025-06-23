package DAO;

import database.JDBC;
import model.OrderComment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderCommentDAO {

    public List<OrderComment> getCommentsByOrderId(int orderId) {
        List<OrderComment> comments = new ArrayList<>();
        String sql = "SELECT * FROM order_comments WHERE order_id = ? ORDER BY created_at DESC";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderComment comment = new OrderComment();
                comment.setId(rs.getInt("id"));
                comment.setOrderId(rs.getInt("order_id"));
                comment.setCommenterId(rs.getInt("commenter_id"));
                comment.setComment(rs.getString("comment"));
                comment.setCreatedAt(rs.getTimestamp("created_at"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return comments;
    }

    public boolean addComment(OrderComment comment) {
        String sql = "INSERT INTO order_comments (order_id, commenter_id, comment, created_at) VALUES (?, ?, ?, ?)";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, comment.getOrderId());
            stmt.setInt(2, comment.getCommenterId());
            stmt.setString(3, comment.getComment());
            stmt.setTimestamp(4, comment.getCreatedAt());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}