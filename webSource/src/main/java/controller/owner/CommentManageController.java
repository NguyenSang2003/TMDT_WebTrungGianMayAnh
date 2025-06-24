package controller.owner;

import DAO.ProductDAO;
import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CommentView;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/owner/comments")
public class CommentManageController extends HttpServlet {
    private ProductDAO productDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User owner = (User) session.getAttribute("user");

        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");  // toggleProductComment hoặc toggleOwnerReview
        String idParam = req.getParameter("id");
        String isShowParam = req.getParameter("isShow");

        try {
            if (action != null && idParam != null && isShowParam != null) {
                int id = Integer.parseInt(idParam);
                int isShow = Integer.parseInt(isShowParam); // 1 hoặc 0

                if ("toggleProductComment".equals(action)) {
                    boolean updated = productDAO.updateProductReviewShow(id, isShow);
                    if (updated) {
                        req.setAttribute("message", isShow == 1 ? "Đã hiện lại bình luận sản phẩm!" : "Đã ẩn bình luận sản phẩm!");
                    } else {
                        req.setAttribute("message", "Có lỗi khi cập nhật trạng thái bình luận sản phẩm!");
                    }
                } else if ("toggleOwnerReview".equals(action)) {
                    boolean updated = userDAO.updateOwnerReviewShow(id, isShow);
                    if (updated) {
                        req.setAttribute("message", isShow == 1 ? "Đã hiện lại đánh giá!" : "Đã ẩn đánh giá!");
                    } else {
                        req.setAttribute("message", "Có lỗi khi cập nhật trạng thái đánh giá!");
                    }
                }

                resp.sendRedirect(req.getContextPath() + "/owner/comments");
                return;
            }

            // Load dữ liệu bình luận & đánh giá
            List<CommentView> productComments = productDAO.getProductCommentsByOwnerId(owner.getId());
            List<CommentView> ownerComments = userDAO.getOwnerComments(owner.getId());

            req.setAttribute("productComments", productComments);
            req.setAttribute("ownerComments", ownerComments);
            req.getRequestDispatcher("/owner/commentManage.jsp").forward(req, resp);

        } catch (SQLException | NumberFormatException e) {
            throw new RuntimeException(e);
        }
    }
}
