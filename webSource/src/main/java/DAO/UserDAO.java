package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.JDBC;
import model.CommentView;
import model.User;

public class UserDAO {

    public boolean checkEmailExist(String email) {
        Connection connection = null;
        boolean emailExists = false;

        try {
            connection = JDBC.getConnection();
            String query = "SELECT 1 FROM users WHERE email = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                emailExists = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi kiểm tra email: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }

        return emailExists;
    }

    public boolean checkUsernameExist(String username) {
        Connection connection = null;
        boolean exists = false;

        try {
            connection = JDBC.getConnection();
            String query = "SELECT 1 FROM users WHERE username = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                exists = true;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi kiểm tra username: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }

        return exists;
    }

    public boolean registerWithEmail(String email, String username, String password) {
        if (checkEmailExist(email)) {
            return false; // Email đã tồn tại, không thể đăng ký
        }

        Connection connection = null;

        try {
            connection = JDBC.getConnection();

            String insert = "INSERT INTO users (username, password, email, role, created_at, updated_at) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(insert);

            java.sql.Timestamp now = new java.sql.Timestamp(System.currentTimeMillis());

            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setString(4, "khach_thue"); // Gán mặc định là "khach_thue", bạn có thể thay đổi nếu muốn
            stmt.setTimestamp(5, now); // created_at
            stmt.setTimestamp(6, now); // updated_at

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi đăng ký tài khoản: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
    }

    public User login(String email, String password) {
        Connection connection = null;
        User user = null;

        try {
            connection = JDBC.getConnection();

            String query = "SELECT id, username, email, role, isVerifyEmail, is_active, created_at, updated_at FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setVerifyEmail(rs.getBoolean("isVerifyEmail"));
                user.setActive(rs.getBoolean("is_active"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi đăng nhập: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }

        return user;
    }

    //    xác thực gmail
    public void markEmailVerified(String email) {
        try (Connection conn = JDBC.getConnection()) {
            String sql = "UPDATE users SET isVerifyEmail = true WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi xác minh email: " + e.getMessage(), e);
        }
    }

    public User getUserByEmail(String email) {
        Connection connection = null;
        User user = null;

        try {
            connection = JDBC.getConnection();
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setVerifyEmail(rs.getBoolean("isVerifyEmail"));
                user.setActive(rs.getBoolean("is_active"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy user theo email: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
        return user;
    }

    public boolean isEmailVerified(String email) {
        Connection connection = null;
        boolean isVerified = false;

        try {
            connection = JDBC.getConnection();

            String query = "SELECT isVerifyEmail FROM users WHERE email = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                isVerified = rs.getBoolean("isVerifyEmail");
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi kiểm tra xác minh email: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }

        return isVerified;
    }

    public List<User> getAllUsersForAdmin() {
        List<User> users = new ArrayList<>();
        Connection connection = null;

        try {
            connection = JDBC.getConnection();
            String query = "SELECT id, username, email, role, isVerifyEmail, is_active, created_at FROM users";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setVerifyEmail(rs.getBoolean("isVerifyEmail"));
                user.setActive(rs.getBoolean("is_active"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi lấy danh sách người dùng: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }

        return users;
    }

    public User getUserById(int id) {
        Connection connection = null;
        User user = null;

        try {
            connection = JDBC.getConnection();
            String query = "SELECT * FROM users WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                user.setVerifyEmail(rs.getBoolean("isVerifyEmail"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi tìm user theo ID: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }

        return user;
    }

    /**
     * Cập nhật mật khẩu mới dựa vào email của người dùng.
     *
     * @param email       Email của người dùng cần cập nhật mật khẩu.
     * @param newPassword Mật khẩu mới cần cập nhật.
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean updatePasswordByEmail(String email, String newPassword) {
        Connection connection = null;
        try {
            // Lấy kết nối từ JDBC
            connection = JDBC.getConnection();

            // Cập nhật mật khẩu trong bảng users
            String sql = "UPDATE users SET password = ?, updated_at = ? WHERE email = ?";

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, newPassword);
            stmt.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis()));
            stmt.setString(3, email);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi cập nhật mật khẩu: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }
    }

    // lấy bình luận về owner
    public List<CommentView> getOwnerComments(int ownerId) {
        List<CommentView> list = new ArrayList<>();
        String sql = "SELECT orv.id, u.username AS commenter, orv.rating, orv.comment, orv.created_at, orv.is_show " +
                "FROM owner_reviews orv " +
                "JOIN users u ON orv.reviewer_id = u.id " +
                "WHERE orv.owner_id = ? " +
                "ORDER BY orv.created_at DESC";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CommentView c = new CommentView();
                c.setId(rs.getInt("id"));
                c.setCommenter(rs.getString("commenter"));
                c.setRating(rs.getInt("rating"));
                c.setComment(rs.getString("comment"));
                c.setCreatedAt(rs.getTimestamp("created_at").toString());
                c.setIsShow(rs.getInt("is_show")); // Quan trọng để hiện trạng thái nút Ẩn/Hiện trên giao diện
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public boolean updateOwnerReviewShow(int id, int isShow) throws SQLException {
        String sql = "UPDATE owner_reviews SET is_show = ? WHERE id = ?";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, isShow);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateProductActive(int id, int isActive) throws SQLException {
        String sql = "UPDATE products SET is_active = ? WHERE id = ?";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, isActive);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

}
