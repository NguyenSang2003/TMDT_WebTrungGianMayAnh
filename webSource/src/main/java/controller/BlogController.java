package controller;

import java.io.IOException;
import java.util.List;

import DAO.BlogViewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BlogView;

@WebServlet("/blog")
public class BlogController extends HttpServlet {
    private BlogViewDAO blogViewDAO = new BlogViewDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<BlogView> blogs = blogViewDAO.getAllBlogViews();
        req.setAttribute("blogs", blogs);
        req.getRequestDispatcher("blog.jsp").forward(req, resp);
    }
}
