package controller;

import DAO.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO userDAO = new UserDAO();

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("status", "failed");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        boolean loginSuccess = userDAO.isLogin(email, password);

        if (loginSuccess) {
            User user = userDAO.getUserByEmail(email);

            if (user == null) {
                req.setAttribute("status", "failed");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                return;
            }

            if (!user.isVerifyEmail()) {
                // Chuyển hướng sang trang xác minh email
                req.setAttribute("email", email);
                req.getRequestDispatcher("GmailVerify.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userName", user.getUsername());

            if ("admin".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect("admin/OrderRental.jsp");
            } else {
                resp.sendRedirect("index.jsp");
            }

        } else {
            req.setAttribute("status", "failed");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}