package DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.JDBC;
import model.BookingSchedule;
import model.CommentView;
import model.Product;
import model.ProductView;

public class ProductDAO {

    public List<CommentView> getProductCommentsByOwnerId(int ownerId) {
        List<CommentView> comments = new ArrayList<>();
        String sql = "SELECT pr.id, u.username AS commenter, pr.rating, pr.comment, pr.created_at, p.name AS productName, pr.is_show " +
                "FROM product_reviews pr " +
                "JOIN products p ON pr.product_id = p.id " +
                "JOIN users u ON pr.reviewer_id = u.id " +
                "WHERE p.user_id = ? " +
                "ORDER BY pr.created_at DESC";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CommentView comment = new CommentView();
                comment.setId(rs.getInt("id"));
                comment.setCommenter(rs.getString("commenter"));
                comment.setRating(rs.getInt("rating"));
                comment.setComment(rs.getString("comment"));
                comment.setCreatedAt(rs.getTimestamp("created_at").toString());
                comment.setProductName(rs.getString("productName"));
                comment.setIsShow(rs.getInt("is_show")); // Quan trọng để điều khiển nút Ẩn/Hiện
                comments.add(comment);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return comments;
    }


    public boolean deleteProductComment(int commentId, int ownerId) {
        String sql = "DELETE pr FROM product_reviews pr " +
                "JOIN products p ON pr.product_id = p.id " +
                "WHERE pr.id = ? AND p.user_id = ?";


        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, commentId);
            ps.setInt(2, ownerId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addProduct(Product product) {
        try (Connection connection = JDBC.getConnection()) {
            String query = "INSERT INTO products (user_id, name, price_per_day, quantity, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query);

            java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
            stmt.setInt(1, product.getUserId());
            stmt.setString(2, product.getName());
            stmt.setBigDecimal(3, product.getPricePerDay());
            stmt.setInt(4, product.getQuantity());
            stmt.setString(5, product.getStatus());
            stmt.setTimestamp(6, now);
            stmt.setTimestamp(7, now);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm sản phẩm: " + e.getMessage(), e);
        }
    }

    public List<Product> getAllProductsByUserId(int userId) {
        List<Product> products = new ArrayList<>();
        try (Connection connection = JDBC.getConnection()) {
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
        }
        return products;
    }

    public Product getProductById(int productId) {
        Product product = null;
        try (Connection connection = JDBC.getConnection()) {
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
        }
        return product;
    }

    public boolean updateProduct(Product product) {
        try (Connection connection = JDBC.getConnection()) {
            String query = "UPDATE products SET name = ?, price_per_day = ?, quantity = ?, status = ?, updated_at = ? WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);

            java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
            stmt.setString(1, product.getName());
            stmt.setBigDecimal(2, product.getPricePerDay());
            stmt.setInt(3, product.getQuantity());
            stmt.setString(4, product.getStatus());
            stmt.setTimestamp(5, now);
            stmt.setInt(6, product.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật sản phẩm: " + e.getMessage(), e);
        }
    }

    public boolean deleteProduct(int productId) {
        try (Connection connection = JDBC.getConnection()) {
            String query = "DELETE FROM products WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa sản phẩm: " + e.getMessage(), e);
        }
    }

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

    public List<BookingSchedule> getBookingsByProductId(int productId) {
        List<BookingSchedule> bookings = new ArrayList<>();
        String sql = "SELECT * FROM booking_schedule WHERE product_id = ? AND status IN ('cho_duyet', 'xac_nhan')";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                BookingSchedule booking = new BookingSchedule();
                booking.setId(rs.getInt("id"));
                booking.setProductId(rs.getInt("product_id"));
                booking.setRenterId(rs.getInt("renter_id"));
                booking.setOwnerId(rs.getInt("owner_id"));
                booking.setOrderId(rs.getObject("order_id") != null ? rs.getInt("order_id") : null);
                booking.setRentStart(rs.getDate("rent_start"));
                booking.setRentEnd(rs.getDate("rent_end"));
                booking.setStatus(rs.getString("status"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                booking.setUpdatedAt(rs.getTimestamp("updated_at"));
                bookings.add(booking);
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Lỗi khi lấy booking theo sản phẩm: " + ex.getMessage(), ex);
        }

        return bookings;
    }

    public ProductView getProductViewById(int id) {
        String sql = "SELECT p.*, pd.image_url, pd.category, pr.rating FROM products p JOIN product_details pd ON p.id = pd.product_id LEFT JOIN product_reviews pr ON p.id = pr.product_id WHERE p.id = ?";

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
                double rating = rs.getDouble("rating");
                if (rs.wasNull()) {
                    rating = 0;
                }
                pv.setRating(rating);
                pv.setImageUrl(rs.getString("image_url"));
                pv.setCategory(rs.getString("category"));
                return pv;
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Error getting product by id: " + ex.getMessage(), ex);
        }
        return null;
    }

    public int getOwnerIdByProductId(int productId) {
        String sql = "SELECT user_id FROM products WHERE id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public String getImageUrlByProductId(int productId) {
        String imageUrl = null;
        String sql = "SELECT image_url FROM product_details WHERE product_id = ? LIMIT 1";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                imageUrl = rs.getString("image_url");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return imageUrl;
    }
    // Tiện ích định dạng số lượng còn lại
    public String getFormattedQuantity(int quantity) {
        if (quantity <= 0) {
            return "Hết hàng";
        }
        return String.valueOf(quantity);
    }
    // Kiểm tra sản phẩm có đang bị đặt hoặc đang thuê
    public boolean hasActiveBooking(int productId) {
        String sql = "SELECT COUNT(*) FROM booking_schedule WHERE product_id = ? AND status IN ('cho_duyet', 'xac_nhan')";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    //Xoá sản phẩm có kiểm tra quyền và điều kiện
    public boolean deleteProduct(int productId, int ownerId) {
        if (hasActiveBooking(productId)) return false;  // Đang có booking, không cho xoá

        String sql = "DELETE FROM products WHERE id = ? AND user_id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setInt(2, ownerId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public List<ProductView> getProductViewsByOwnerId(int ownerId) {
        List<ProductView> list = new ArrayList<>();
        String sql = "SELECT p.id, p.user_id, p.name, p.price_per_day, p.quantity, p.status, p.created_at, p.updated_at, " +
                "p.view_count, p.sold_count, p.is_active, pd.image_url, pd.category " +
                "FROM products p " +
                "LEFT JOIN product_details pd ON p.id = pd.product_id " +
                "WHERE p.user_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

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
                pv.setCategory(rs.getString("category"));
                pv.setIsActive(rs.getInt("is_active"));  // Lấy trạng thái Ẩn/Hiện
                list.add(pv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean updateProductActive(int id, int isActive) throws SQLException {
        String sql = "UPDATE products SET is_active = ? WHERE id = ?";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, isActive);  // 1 hiện, 0 ẩn
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }
    // Ẩn hoặc Hiện bình luận sản phẩm theo is_show
    public boolean updateProductReviewShow(int id, int isShow) throws SQLException {
        String sql = "UPDATE product_reviews SET is_show = ? WHERE id = ?";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, isShow);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

}



