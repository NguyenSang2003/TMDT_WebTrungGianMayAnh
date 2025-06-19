package DAO;

import database.JDBC;
import model.UserProfile;

import java.sql.*;

public class UserProfileDAO {

    public UserProfile getProfileByUserId(int userId) {
        String sql = "SELECT * FROM user_profiles WHERE user_id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                UserProfile profile = new UserProfile();
                profile.setId(rs.getInt("id"));
                profile.setUserId(rs.getInt("user_id"));
                profile.setFullName(rs.getString("full_name"));
                profile.setIdCardNumber(rs.getString("id_card_number"));
                profile.setAddress(rs.getString("address"));
                profile.setPhoneNumber(rs.getString("phone_number"));
                profile.setDateOfBirth(rs.getDate("date_of_birth"));
                profile.setIdCardImageUrl(rs.getString("id_card_image_url"));
                profile.setIdCardWithUserImageUrl(rs.getString("id_card_with_user_image_url"));
                profile.setVerifiedIdentity(rs.getBoolean("is_verified_identity"));
                profile.setCreatedAt(rs.getTimestamp("created_at"));
                profile.setUpdatedAt(rs.getTimestamp("updated_at"));
                return profile;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy thông tin hồ sơ: " + e.getMessage(), e);
        }
        return null;
    }

    public void updateProfile(UserProfile profile) {
        String sql = "UPDATE user_profiles SET full_name = ?, id_card_number = ?, address = ?, phone_number = ?, date_of_birth = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, profile.getFullName());
            stmt.setString(2, profile.getIdCardNumber());
            stmt.setString(3, profile.getAddress());
            stmt.setString(4, profile.getPhoneNumber());
            stmt.setDate(5, profile.getDateOfBirth());
            stmt.setInt(6, profile.getUserId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật hồ sơ: " + e.getMessage(), e);
        }
    }

    public void createEmptyProfileForUser(int userId) {
        String sql = "INSERT INTO user_profiles (user_id, created_at, updated_at) VALUES (?, ?, ?)";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            Timestamp now = new Timestamp(System.currentTimeMillis());
            stmt.setInt(1, userId);
            stmt.setTimestamp(2, now);
            stmt.setTimestamp(3, now);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tạo hồ sơ trống: " + e.getMessage(), e);
        }
    }

    // phân upload ảnh
    public void updateIdCardImage(int userId, String imageUrl) {
        String sql = "UPDATE user_profiles SET id_card_image_url = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, imageUrl);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật ảnh CMND: " + e.getMessage(), e);
        }
    }

    public void updateIdCardWithUserImage(int userId, String imageUrl) {
        String sql = "UPDATE user_profiles SET id_card_with_user_image_url = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, imageUrl);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật ảnh chụp cùng CMND: " + e.getMessage(), e);
        }
    }

}
