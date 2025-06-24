package DAO;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import database.JDBC;
import model.Product;
import model.ProductDetail;
import model.ProductView;

public class ProductDAO {

    // Thêm mới sản phẩm // sửa lại thương thức addProduct để thêm được vào product_details
    public boolean addProduct(Product product, String brand, String imageUrl, String category, String model, String color, BigDecimal weight, String description) {
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            connection.setAutoCommit(false); // bắt đầu transaction

            // Insert vào bảng products
            String query = "INSERT INTO products (user_id, name, price_per_day, quantity, status, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());
            stmt.setInt(1, product.getUserId());
            stmt.setString(2, product.getName());
            stmt.setBigDecimal(3, product.getPricePerDay());
            stmt.setInt(4, product.getQuantity());
            stmt.setString(5, product.getStatus());
            stmt.setTimestamp(6, now); // created_at
            stmt.setTimestamp(7, now); // updated_at

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                connection.rollback();
                return false;
            }

            // Lấy product_id vừa insert
            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int productId = generatedKeys.getInt(1);

                // Insert vào product_details
                String detailQuery = "INSERT INTO product_details (product_id, brand, image_url,category,model,color,weight,description) VALUES (?, ?, ?,?, ?, ?,?,?)";
                PreparedStatement detailStmt = connection.prepareStatement(detailQuery);
                detailStmt.setInt(1, productId);
                detailStmt.setString(2, brand);
                detailStmt.setString(3, imageUrl);
                detailStmt.setString(4, category);
                detailStmt.setString(5, model);
                detailStmt.setString(6, color);
                detailStmt.setBigDecimal(7, weight);
                detailStmt.setString(8, description);
                detailStmt.executeUpdate();
            } else {
                connection.rollback();
                return false;
            }

            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                if (connection != null) connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            throw new RuntimeException("Lỗi khi thêm sản phẩm: " + e.getMessage(), e);
        } finally {
            try {
                if (connection != null) connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
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
    public boolean updateProduct(Product product, ProductDetail detail) {
        Connection conn = null;
        PreparedStatement stmtProduct = null;
        PreparedStatement stmtDetail = null;
        boolean success = false;

        try {
            conn = JDBC.getConnection();
            conn.setAutoCommit(false); // transaction

            String updateProductSQL = "UPDATE products SET name = ?, price_per_day = ?, quantity = ?,status = ?, updated_at = ? WHERE id = ?";
            stmtProduct = conn.prepareStatement(updateProductSQL);
            stmtProduct.setString(1, product.getName());
            stmtProduct.setBigDecimal(2, product.getPricePerDay());
            stmtProduct.setInt(3, product.getQuantity());
            stmtProduct.setString(4, product.getStatus());
            stmtProduct.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            stmtProduct.setInt(6, product.getId());
            int rows1 = stmtProduct.executeUpdate();

            String updateDetailSQL = "UPDATE product_details SET brand=?, category=?, model=?, color=?, weight=?, description=?, image_url=? WHERE product_id=?";
            stmtDetail = conn.prepareStatement(updateDetailSQL);
            stmtDetail.setString(1, detail.getBrand());
            stmtDetail.setString(2, detail.getCategory());
            stmtDetail.setString(3, detail.getModel());
            stmtDetail.setString(4, detail.getColor());
            stmtDetail.setBigDecimal(5, detail.getWeight());
            stmtDetail.setString(6, detail.getDescription());
            stmtDetail.setString(7, detail.getImageUrl());
            stmtDetail.setInt(8, product.getId());
            int rows2 = stmtDetail.executeUpdate();

            if (rows1 > 0 && rows2 > 0) {
                conn.commit();
                success = true;
            } else {
                conn.rollback();
            }

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            throw new RuntimeException("Lỗi khi cập nhật sản phẩm và chi tiết: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(conn);
        }

        return success;
    }

    // Xóa sản phẩm // sửa lại phương thức để xóa trong cả product details do khóa ngoại
    public boolean deleteProduct(int productId) {
        Connection connection = null;
        try {
            connection = JDBC.getConnection();
            connection.setAutoCommit(false); // Bắt đầu transaction

            // Xóa product_details trước
            String deleteDetailsQuery = "DELETE FROM product_details WHERE product_id = ?";
            PreparedStatement deleteDetailsStmt = connection.prepareStatement(deleteDetailsQuery);
            deleteDetailsStmt.setInt(1, productId);
            deleteDetailsStmt.executeUpdate();

            // Xóa products sau
            String deleteProductQuery = "DELETE FROM products WHERE id = ?";
            PreparedStatement deleteProductStmt = connection.prepareStatement(deleteProductQuery);
            deleteProductStmt.setInt(1, productId);
            int rows = deleteProductStmt.executeUpdate();

            connection.commit();
            return rows > 0;
        } catch (SQLException e) {
            try {
                if (connection != null) connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            throw new RuntimeException("Lỗi khi xóa sản phẩm: " + e.getMessage(), e);
        } finally {
            try {
                if (connection != null) connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
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

    public void updateIsActive(int id, int isActive) {
        String sql = "UPDATE products SET is_active = ? WHERE id = ?";
        try (
                Connection connection = JDBC.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {
            statement.setInt(1, isActive);
            statement.setInt(2, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ProductView getProductDetail(int productId) {
        String sql =
                "SELECT p.id, p.name, p.price_per_day, pd.brand, p.status, pd.image_url, p.is_active " +
                        "FROM products p " +
                        "JOIN product_details pd ON p.id = pd.product_id " +
                        "WHERE p.id = ?";

        try (
                Connection connection = JDBC.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {
            statement.setInt(1, productId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    ProductView product = new ProductView();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setPricePerDay(rs.getBigDecimal("price_per_day"));
                    product.setBrand(rs.getString("brand"));
                    product.setStatus(rs.getString("status"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setIsActive(rs.getInt("is_active"));
                    return product;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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