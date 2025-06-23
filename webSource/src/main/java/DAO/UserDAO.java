package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.JDBC;
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
            // sẽ sưa phương thuc nay
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
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, password, email, role, isVerifyEmail, is_active, created_at, updated_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword()); // nhớ mã hoá nếu có
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getRole());
            stmt.setBoolean(5, user.isVerifyEmail());
            stmt.setBoolean(6, user.isActive());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi thêm user: " + e.getMessage(), e);
        }
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username=?, email=?, role=?, isVerifyEmail=?, is_active=?, updated_at=NOW() WHERE id=?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getRole());
            stmt.setBoolean(4, user.isVerifyEmail());
            stmt.setBoolean(5, user.isActive());
            stmt.setInt(6, user.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật user: " + e.getMessage(), e);
        }
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id=?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xoá user: " + e.getMessage(), e);
        }
    }


    public List<User> filterUsers(String role, Boolean isActive) {
        List<User> users = new ArrayList<>();
        Connection connection = null;

        try {
            connection = JDBC.getConnection();
            StringBuilder query = new StringBuilder("SELECT id, username, email, role, isVerifyEmail, is_active, created_at FROM users WHERE 1=1");

            List<Object> params = new ArrayList<>();
            if (role != null && !role.isEmpty()) {
                query.append(" AND role = ?");
                params.add(role);
            }
            if (isActive != null) {
                query.append(" AND is_active = ?");
                params.add(isActive);
            }

            PreparedStatement stmt = connection.prepareStatement(query.toString());

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

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
            throw new RuntimeException("Lỗi lọc người dùng: " + e.getMessage(), e);
        } finally {
            JDBC.closeConnection(connection);
        }

        return users;
    }

    public List<User> searchUsers(String keyword, String role, Boolean isActive) {
        List<User> users = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM users WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (username LIKE ? OR email LIKE ?)");
        }
        if (role != null && !role.trim().isEmpty()) {
            query.append(" AND role = ?");
        }
        if (isActive != null) {
            query.append(" AND is_active = ?");
        }

        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchTerm = "%" + keyword.trim() + "%";
                stmt.setString(index++, searchTerm);
                stmt.setString(index++, searchTerm);
            }
            if (role != null && !role.trim().isEmpty()) {
                stmt.setString(index++, role);
            }
            if (isActive != null) {
                stmt.setBoolean(index++, isActive);
            }

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
            throw new RuntimeException("Lỗi tìm kiếm người dùng: " + e.getMessage(), e);
        }

        return users;
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

    public boolean updateUserActiveStatus(int userId, boolean isActive) {
        String sql = "UPDATE users SET is_active = ?, updated_at = NOW() WHERE id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isActive); // true/false sẽ map thành 1/0 trong MySQL
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật is_active: " + e.getMessage(), e);
        }
    }
    public boolean updateUserRole(int userId, String newRole) {
        String sql = "UPDATE users SET role = ? WHERE id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newRole);
            ps.setInt(2, userId);
            int rowsUpdated = ps.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated); // DEBUG
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}

