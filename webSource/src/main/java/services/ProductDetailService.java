package services;

import database.JDBC;
import model.ProductDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductDetailService {

    public ProductDetail getProductDetailByProductId(int productId) {
        ProductDetail detail = null;
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "SELECT * FROM product_details WHERE product_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                detail = new ProductDetail();
                detail.setProductId(rs.getInt("product_id"));
                detail.setDescription(rs.getString("description"));
                detail.setBrand(rs.getString("brand"));
                detail.setModel(rs.getString("model"));
                detail.setImageUrl(rs.getString("image_url"));
                detail.setCategory(rs.getString("category"));
                detail.setProductCondition(rs.getString("product_condition"));
                detail.setAccessories(rs.getString("accessories"));
                detail.setWeight(rs.getBigDecimal("weight"));
                detail.setColor(rs.getString("color"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy chi tiết sản phẩm: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
        return detail;
    }
}