package services;

import java.sql.*;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.Locale;
import java.util.ArrayList;
import java.util.List;
import java.math.RoundingMode;

import database.JDBC;
import model.Product;
import model.ProductDetail;
import model.ProductView;

public class ProductService {

    // Lấy danh sách sản phẩm mới nhất (join bảng products và product_details)
    public List<ProductView> getLatestProductsWithDetails() {
        List<ProductView> list = new ArrayList<>();
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "SELECT p.*, pd.image_url " +
                    "FROM products p " +
                    "JOIN product_details pd ON p.id = pd.product_id " +
                    "ORDER BY p.created_at DESC LIMIT 5";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
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
                pv.setImageUrl(rs.getString("image_url"));
                list.add(pv);
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Error getting latest products: " + ex.getMessage(), ex);
        } finally {
            JDBC.closeConnection(connection);
        }
        return list;
    }

    // Lấy danh sách sản phẩm bán chạy (theo sold_count)
    public List<ProductView> getBestSellingProductsWithDetails() {
        List<ProductView> list = new ArrayList<>();
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "SELECT p.*, pd.image_url " +
                    "FROM products p " +
                    "JOIN product_details pd ON p.id = pd.product_id " +
                    "ORDER BY p.sold_count DESC LIMIT 5";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
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
                pv.setImageUrl(rs.getString("image_url"));
                list.add(pv);
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Error getting best selling products: " + ex.getMessage(), ex);
        } finally {
            JDBC.closeConnection(connection);
        }
        return list;
    }

    // Lấy danh sách sản phẩm được xem nhiều nhất (theo view_count)
    public List<ProductView> getMostViewedProductsWithDetails() {
        List<ProductView> list = new ArrayList<>();
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "SELECT p.*, pd.image_url " +
                    "FROM products p " +
                    "JOIN product_details pd ON p.id = pd.product_id " +
                    "ORDER BY p.view_count DESC LIMIT 6";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
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
                pv.setImageUrl(rs.getString("image_url"));
                list.add(pv);
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Error getting most viewed products: " + ex.getMessage(), ex);
        } finally {
            JDBC.closeConnection(connection);
        }
        return list;
    }

    public List<ProductView> getAllProducts() {
        List<ProductView> list = new ArrayList<>();
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "SELECT p.*, " +
                    "ANY_VALUE(pd.image_url) AS image_url, " +
                    "ANY_VALUE(pd.category) AS category, " +
                    "IFNULL(AVG(pr.rating), 0) AS rating " +
                    "FROM products p " +
                    "JOIN product_details pd ON p.id = pd.product_id " +
                    "LEFT JOIN product_reviews pr ON p.id = pr.product_id " +
                    "GROUP BY p.id";

            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
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
                list.add(pv);
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Error getting most viewed products: " + ex.getMessage(), ex);
        } finally {
            JDBC.closeConnection(connection);
        }
        return list;
    }

    // Lấy chi tiết 1 sản phẩm theo ID
    public ProductView getProductViewById(int productId) {
        ProductView pv = null;
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            String query = "SELECT p.*, pd.image_url " +
                    "FROM products p " +
                    "JOIN product_details pd ON p.id = pd.product_id " +
                    "WHERE p.id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                pv = new ProductView();
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
                pv.setImageUrl(rs.getString("image_url"));
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Error getting product view by ID: " + ex.getMessage(), ex);
        } finally {
            JDBC.closeConnection(connection);
        }
        return pv;
    }

    // Lấy danh sách sản phẩm liên quan cùng category, loại trừ sản phẩm hiện tại
    public List<ProductView> getRelatedProducts(int productId, String category, int limit) {
        List<ProductView> relatedProducts = new ArrayList<>();
        Connection connection = null;

        try {
            connection = JDBC.getConnection();
            String query = "SELECT p.*, pd.image_url, pd.brand, pd.category " +
                    "FROM products p " +
                    "JOIN product_details pd ON p.id = pd.product_id " +
                    "WHERE p.id != ? AND pd.category = ? " +
                    "ORDER BY p.created_at DESC " +
                    "LIMIT ?";

            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);
            stmt.setString(2, category);
            stmt.setInt(3, limit);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
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
                pv.setImageUrl(rs.getString("image_url"));
                pv.setBrand(rs.getString("brand"));
                pv.setCategory(rs.getString("category"));

                // Format giá thuê/ngày để dùng trong EL
                pv.setFormattedPricePerDay(
                        NumberFormat.getInstance(new Locale("vi", "VN"))
                                .format(pv.getPricePerDay())
                );

                relatedProducts.add(pv);
            }

        } catch (SQLException ex) {
            throw new RuntimeException("Error getting related products: " + ex.getMessage(), ex);
        } finally {
            JDBC.closeConnection(connection);
        }

        return relatedProducts;
    }
    // lấy tất cả danh sách sản phẩm
    public List<ProductView> getAllProducts() {

        List<ProductView> productView = new ArrayList<>();

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            connection = JDBC.getConnection();
            statement = connection.prepareStatement("SELECT p.id, p.name, p.price_per_day, pd.brand, p.status, pd.image_url " +
                    "FROM products p JOIN product_details pd ON p.id = pd.product_id");
            rs = statement.executeQuery();

            while (rs.next()) {
                ProductView product = new ProductView();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPricePerDay(rs.getBigDecimal("price_per_day"));

                product.setBrand(rs.getString("brand"));
                product.setStatus(rs.getString("status"));
                product.setImageUrl(rs.getString("image_url"));

                productView.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (statement != null) statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            JDBC.closeConnection(connection);
        }
        return productView;
    }




    /**
     * Lấy danh sách ProductView hiển thị trong product grid của shop.
     * Chỉ lấy thông tin: id, name, price_per_day, image_url, category,
     * trung bình đánh giá (averageRating) và tổng số đánh giá (totalReviews).
     */
    public List<ProductView> getAllProductViews() {
        List<ProductView> productViews = new ArrayList<>();
        Connection connection = null;
        String sql = "SELECT p.id, p.name, p.price_per_day, pd.image_url, pd.category, " +
                "AVG(pr.rating) AS averageRating, COUNT(pr.rating) AS totalReviews " +
                "FROM products p " +
                "JOIN product_details pd ON p.id = pd.product_id " +
                "LEFT JOIN product_reviews pr ON p.id = pr.product_id " +
                "GROUP BY p.id, p.name, p.price_per_day, pd.image_url, pd.category";

        try {
            connection = JDBC.getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ProductView pv = new ProductView();
                pv.setId(rs.getInt("id"));
                pv.setName(rs.getString("name"));
                pv.setPricePerDay(rs.getBigDecimal("price_per_day"));
                pv.setImageUrl(rs.getString("image_url"));
                pv.setCategory(rs.getString("category"));

                // Nếu không có review, AVG(pr.rating) có thể trả về null
                BigDecimal avgRating = rs.getBigDecimal("averageRating");
                if (avgRating == null) {
                    avgRating = BigDecimal.ZERO;
                }
                // Làm tròn lên
                int roundedRating = avgRating.setScale(0, RoundingMode.CEILING).intValue();
                pv.setAverageRating(new BigDecimal(roundedRating));  // Lưu lại giá trị đã làm tròn
                pv.setTotalReviews(rs.getInt("totalReviews"));

                productViews.add(pv);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách sản phẩm: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
        return productViews;
    }

}