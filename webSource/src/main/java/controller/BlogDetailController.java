package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import DAO.BlogViewDAO;
import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
}
