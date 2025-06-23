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
import model.Product;
import model.ProductView;

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

    public List<BookingSchedule> getBookingsByProductId(int productId) {
        String sql = "SELECT * FROM booking_schedule WHERE product_id = ? AND status IN ('cho_duyet', 'xac_nhan')";
        List<BookingSchedule> bookings = new ArrayList<>();

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
        String sql = "SELECT p.*, pd.image_url, pd.category, pr.rating " +
                "FROM products p " +
                "JOIN product_details pd ON p.id = pd.product_id " +
                "LEFT JOIN product_reviews pr ON p.id = pr.product_id " +
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
        return null; // nếu không tìm thấy
    }

    public int getOwnerIdByProductId(int productId) {
        String sql = "SELECT user_id FROM products WHERE id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt("user_id");
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

    // tìm kiếm sản phẩm theo từ khóa
    public static List<ProductView> getFilteredProducts(String keyword, String brand, String model, String category) {
        List<ProductView> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.*, pd.image_url, pd.category, pd.brand, pd.model ");
        sql.append("FROM products p ");
        sql.append("LEFT JOIN product_details pd ON p.id = pd.product_id ");
        sql.append("WHERE 1=1 ");

        // Danh sách các tham số sẽ được gán cho PreparedStatement
        List<Object> parameters = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND p.name LIKE ? ");
            parameters.add("%" + keyword + "%");
        }
        if (brand != null && !brand.trim().isEmpty()) {
            sql.append("AND pd.brand = ? ");
            parameters.add(brand);
        }
        if (model != null && !model.trim().isEmpty()) {
            sql.append("AND pd.model = ? ");
            parameters.add(model);
        }
        if (category != null && !category.trim().isEmpty()) {
            sql.append("AND pd.category = ? ");
            parameters.add(category);
        }

        try (Connection connection = JDBC.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql.toString())) {

            // Gán các tham số vào PreparedStatement
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ProductView productView = new ProductView();
                // Lấy dữ liệu từ bảng products
                productView.setId(rs.getInt("id"));
                productView.setUserId(rs.getInt("user_id"));
                productView.setName(rs.getString("name"));
                productView.setPricePerDay(rs.getBigDecimal("price_per_day"));
                productView.setQuantity(rs.getInt("quantity"));
                productView.setStatus(rs.getString("status"));
                productView.setCreatedAt(rs.getTimestamp("created_at"));
                productView.setUpdatedAt(rs.getTimestamp("updated_at"));
                productView.setViewCount(rs.getInt("view_count"));
                productView.setSoldCount(rs.getInt("sold_count"));

                // Lấy dữ liệu từ bảng product_details
                productView.setImageUrl(rs.getString("image_url"));
                productView.setCategory(rs.getString("category"));
                productView.setBrand(rs.getString("brand"));
                productView.setModel(rs.getString("model"));

                // Nếu thông tin đánh giá chưa có, có thể để mặc định
                productView.setAverageRating(BigDecimal.ZERO);
                productView.setTotalReviews(0);

                products.add(productView);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm và lọc sản phẩm: " + e.getMessage(), e);
        }
        return products;
    }

}