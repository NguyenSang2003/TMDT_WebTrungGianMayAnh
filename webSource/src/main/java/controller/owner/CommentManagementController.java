package controller.owner;

import DAO.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Comment;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/owner/commentManagement")
public class CommentManagementController extends HttpServlet {
    private CommentDAO commentDAO = new CommentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        List<Comment> comments = commentDAO.getAllCommentsForOwner(user.getId());
        req.setAttribute("commentList", comments);
        req.getRequestDispatcher("commentManage.jsp").forward(req, resp);
    }
}
