package DAO;

import database.JDBC;
import model.ProductView;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {
    public boolean addToWishlist(int userId, int productId) {
        Connection conn = null;
        try {
            conn = JDBC.getConnection();
            String sql = "INSERT INTO wishlist (user_id, product_id, added_at) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm wishlist: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(conn);
        }
    }

    public List<ProductView> getWishlistByUserId(int userId) {
        Connection conn = null;
        List<ProductView> wishlist = new ArrayList<>();
        try {
            conn = JDBC.getConnection();
            String sql = "SELECT p.id, p.name, p.price_per_day, d.image_url " +
                    "FROM wishlist w " +
                    "JOIN products p ON w.product_id = p.id " +
                    "LEFT JOIN product_details d ON p.id = d.product_id " +
                    "WHERE w.user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductView pv = new ProductView();
                pv.setId(rs.getInt("id"));
                pv.setName(rs.getString("name"));
                pv.setPricePerDay(rs.getBigDecimal("price_per_day"));
                pv.setImageUrl(rs.getString("image_url"));
                wishlist.add(pv);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy danh sách wishlist: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(conn);
        }
        return wishlist;
    }

    public boolean removeFromWishlist(int userId, int productId) {
        Connection conn = null;
        try {
            conn = JDBC.getConnection();
            String sql = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi xóa wishlist: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(conn);
        }
    }
}