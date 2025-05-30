package DAO;

import database.JDBC;
import model.ProductView;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartDAO {

    public ProductView getProductById(int id) {
        String sql = "SELECT p.*, pd.image_url, pd.category " +
                "FROM products p JOIN product_details pd ON p.id = pd.product_id " +
                "WHERE p.id = ?";
        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                ProductView pv = new ProductView();
                pv.setId(rs.getInt("id"));
                pv.setUserId(rs.getInt("user_id"));
                pv.setName(rs.getString("name"));
                pv.setPricePerDay(rs.getBigDecimal("price_per_day"));
                pv.setQuantity(rs.getInt("quantity"));
                pv.setStatus(rs.getString("status"));
                pv.setCreatedAt(rs.getTimestamp("created_at"));
                pv.setUpdatedAt(rs.getTimestamp("updated_at"));
                pv.setViewCount(rs.getInt("view_count"));
                pv.setSoldCount(rs.getInt("sold_count"));
                pv.setRating(rs.getDouble("rating"));
                pv.setImageUrl(rs.getString("image_url"));
                pv.setCategory(rs.getString("category"));
                return pv;
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Error getting product by id: " + ex.getMessage(), ex);
        }
        return null; // nếu không tìm thấy
    }

}
