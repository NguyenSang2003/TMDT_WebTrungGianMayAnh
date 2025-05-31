package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.JDBC;
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
}