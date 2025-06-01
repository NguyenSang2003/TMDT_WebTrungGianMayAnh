package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.JDBC;
import model.Product;

public class ProductDAO {

    // Thêm mới sản phẩm
    public boolean addProduct(Product product) {
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "INSERT INTO products (user_id, name, price_per_day, quantity, status, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query);

            java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
            stmt.setInt(1, product.getUserId());
            stmt.setString(2, product.getName());
            stmt.setBigDecimal(3, product.getPricePerDay());
            stmt.setInt(4, product.getQuantity());
            stmt.setString(5, product.getStatus());
            stmt.setTimestamp(6, now); // created_at
            stmt.setTimestamp(7, now); // updated_at

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
    }

    // Lấy tất cả sản phẩm của người cho thuê
    public List<Product> getAllProductsByUserId(int userId) {
        List<Product> products = new ArrayList<>();
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "SELECT * FROM products WHERE user_id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                populateProductFromResultSet(product, rs);
                products.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
        return products;
    }

    // Lấy thông tin sản phẩm theo ID
    public Product getProductById(int productId) {
        Connection connection = null;
        Product product = null;
        try {
            connection = JDBC.getConnection();
            String query = "SELECT * FROM products WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                product = new Product();
                populateProductFromResultSet(product, rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy sản phẩm theo ID: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
        return product;
    }

    // Cập nhật thông tin sản phẩm
    public boolean updateProduct(Product product) {
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "UPDATE products SET name = ?, price_per_day = ?, quantity = ?, status = ?, updated_at = ? " +
                    "WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);

            java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
            stmt.setString(1, product.getName());
            stmt.setBigDecimal(2, product.getPricePerDay());
            stmt.setInt(3, product.getQuantity());
            stmt.setString(4, product.getStatus());
            stmt.setTimestamp(5, now); // updated_at
            stmt.setInt(6, product.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật sản phẩm: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
    }

    // Xóa sản phẩm
    public boolean deleteProduct(int productId) {
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "DELETE FROM products WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa sản phẩm: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
    }

    // Phương thức dùng chung để mapping dữ liệu từ ResultSet sang đối tượng Product
    private void populateProductFromResultSet(Product product, ResultSet rs) throws SQLException {
        product.setId(rs.getInt("id"));
        product.setUserId(rs.getInt("user_id"));
        product.setName(rs.getString("name"));
        product.setPricePerDay(rs.getBigDecimal("price_per_day"));
        product.setQuantity(rs.getInt("quantity"));
        product.setStatus(rs.getString("status"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setUpdatedAt(rs.getTimestamp("updated_at"));
        product.setViewCount(rs.getInt("view_count"));
        product.setSoldCount(rs.getInt("sold_count"));
    }

}