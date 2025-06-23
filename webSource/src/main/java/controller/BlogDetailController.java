package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import DAO.BlogViewDAO;
import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BlogComment;
import model.BlogDetailView;
import model.UserView;

@WebServlet("/blog-detail")
public class BlogDetailController extends HttpServlet {
    private BlogViewDAO dao = new BlogViewDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idRaw = req.getParameter("id");
        try {
            int id = Integer.parseInt(idRaw);
            BlogDetailView detail = dao.getBlogDetailById(id);

            // Lấy tác giả blog
            UserView blogAuthor = userDAO.getUserViewById(detail.getBlog().getUserId());
            detail.setBlogAuthor(blogAuthor);

            // Lấy user cho từng comment
            Map<Integer, UserView> commentUserViews = new HashMap<>();
            for (BlogComment cmt : detail.getComments()) {
                int uid = cmt.getUserId();
                if (!commentUserViews.containsKey(uid)) {
                    commentUserViews.put(uid, userDAO.getUserViewById(uid));
                }
            }
            detail.setCommentUserViews(commentUserViews);

            req.setAttribute("detail", detail);
            req.setAttribute("comments", detail.getComments());
            req.getRequestDispatcher("blogDetail.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        model.User currentUser = (model.User) session.getAttribute("user");

        if (currentUser == null) {
            // Chưa đăng nhập -> chuyển hướng về trang đăng nhập
            resp.sendRedirect("login.jsp?redirect=" + req.getRequestURI() + "?" + req.getQueryString());
            return;
        }

        String comment = req.getParameter("comment");
        String blogIdRaw = req.getParameter("id");

        try {
            int blogId = Integer.parseInt(blogIdRaw);
            if (comment != null && !comment.trim().isEmpty()) {
                BlogComment cmt = new BlogComment();
                cmt.setBlogId(blogId);
                cmt.setUserId(currentUser.getId());
                cmt.setComment(comment);
                cmt.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

                try {
                    dao.addComment(cmt); // Gọi DAO để lưu bình luận
                } catch (SQLException e) {
                    e.printStackTrace();
                    resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lưu bình luận");
                    return;
                }
            }
            // Quay lại trang blog-detail
            resp.sendRedirect("blog-detail?id=" + blogId);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

}
