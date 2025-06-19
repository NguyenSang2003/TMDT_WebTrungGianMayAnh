package model;

import java.util.List;
import java.util.Map;

public class BlogDetailView {
    private BlogView blog;
    private List<BlogComment> comments;

    private UserView blogAuthor; // ✅ Thêm tác giả bài viết
    private Map<Integer, UserView> commentUserViews; // ✅ Map user_id → thông tin người comment

    public BlogView getBlog() { return blog; }
    public void setBlog(BlogView blog) { this.blog = blog; }

    public List<BlogComment> getComments() { return comments; }
    public void setComments(List<BlogComment> comments) { this.comments = comments; }

    public UserView getBlogAuthor() { return blogAuthor; }
    public void setBlogAuthor(UserView blogAuthor) { this.blogAuthor = blogAuthor; }

    public Map<Integer, UserView> getCommentUserViews() { return commentUserViews; }
    public void setCommentUserViews(Map<Integer, UserView> commentUserViews) {
        this.commentUserViews = commentUserViews;
    }
}

