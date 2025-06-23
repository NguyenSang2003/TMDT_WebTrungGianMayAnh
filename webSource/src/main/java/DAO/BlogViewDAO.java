package DAO;

import model.BlogComment;
import model.BlogDetailView;
import model.BlogView;
import model.User;
import model.UserProfile;
import model.UserView;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import database.JDBC;

public class BlogViewDAO {
	
	//lấy toàn bộ blog
    public List<BlogView> getAllBlogViews() {
        List<BlogView> blogViews = new ArrayList<>();
        String sql = "SELECT b.*, bc.content, bc.image_url, u.username, up.full_name " +
                "FROM blogs b " +
                "JOIN blog_contents bc ON b.id = bc.blog_id " +
                "JOIN users u ON b.user_id = u.id " +
                "JOIN user_profiles up ON u.id = up.user_id " +
                "WHERE b.is_approved = 0 " +
                "ORDER BY b.created_at DESC";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BlogView view = new BlogView();
                view.setId(rs.getInt("id"));
                view.setUserId(rs.getInt("user_id"));
                view.setTitle(rs.getString("title"));
                view.setApproved(rs.getBoolean("is_approved"));
                view.setApprovedBy((Integer) rs.getObject("approved_by"));
                view.setApprovedAt(rs.getTimestamp("approved_at"));
                view.setCreatedAt(rs.getTimestamp("created_at"));
                view.setUpdatedAt(rs.getTimestamp("updated_at"));
                view.setContent(rs.getString("content"));
                view.setImageUrl(rs.getString("image_url"));

             // 💡 Thêm UserView
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));

                UserProfile profile = new UserProfile();
                profile.setFullName(rs.getString("full_name"));

                UserView userView = new UserView();
                userView.setUser(user);
                userView.setUserProfile(profile);

                view.setUserView(userView);

                blogViews.add(view);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blogViews;
    }
    
    //lấy blog chi tiết theo id
    public BlogDetailView getBlogDetailById(int blogId) {
        BlogDetailView detail = new BlogDetailView();

        // Lấy BlogView
        String blogSql = "SELECT b.id, b.user_id, b.title, b.is_approved, b.approved_by, b.approved_at, "
                + "b.created_at, b.updated_at, bc.content, bc.image_url "
                + "FROM blogs b JOIN blog_contents bc ON b.id = bc.blog_id "
                + "WHERE b.id = ?";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(blogSql)) {
            ps.setInt(1, blogId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                BlogView blog = new BlogView();
                blog.setId(rs.getInt("id"));
                blog.setUserId(rs.getInt("user_id"));
                blog.setTitle(rs.getString("title"));
                blog.setApproved(rs.getBoolean("is_approved"));
                blog.setApprovedBy((Integer) rs.getObject("approved_by"));
                blog.setApprovedAt(rs.getTimestamp("approved_at"));
                blog.setCreatedAt(rs.getTimestamp("created_at"));
                blog.setUpdatedAt(rs.getTimestamp("updated_at"));
                blog.setContent(rs.getString("content"));
                blog.setImageUrl(rs.getString("image_url"));
                detail.setBlog(blog);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Lấy comments
        List<BlogComment> comments = new ArrayList<>();
        String commentSql = "SELECT * FROM blog_comments WHERE blog_id = ? ORDER BY created_at DESC";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(commentSql)) {
            ps.setInt(1, blogId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BlogComment c = new BlogComment();
                c.setId(rs.getInt("id"));
                c.setBlogId(rs.getInt("blog_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setComment(rs.getString("comment"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                comments.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        detail.setComments(comments);
        return detail;
    }
    
    public void addComment(BlogComment comment) throws SQLException {
        String sql = "INSERT INTO blog_comments (blog_id, user_id, comment, created_at) VALUES (?, ?, ?, ?)";
        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, comment.getBlogId());
            ps.setInt(2, comment.getUserId());
            ps.setString(3, comment.getComment());
            ps.setTimestamp(4, comment.getCreatedAt());
            ps.executeUpdate();
        }
    }

}
