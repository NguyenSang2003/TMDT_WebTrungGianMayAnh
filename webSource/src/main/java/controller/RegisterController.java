package controller;

import DAO.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet(name = "register", value = "/register")
public class RegisterController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("userName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String retypePassword = req.getParameter("retypePassword");

        // Nếu chưa gửi dữ liệu từ form, forward sang trang đăng ký
        if (username == null || email == null || password == null || retypePassword == null) {
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        UserDAO userDAO = new UserDAO();

        // Kiểm tra email đã tồn tại
        if (userDAO.checkEmailExist(email)) {
            req.setAttribute("status", "email_exists");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra username đã tồn tại
        if (userDAO.checkUsernameExist(username)) {
            req.setAttribute("status", "username_exists");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra mật khẩu
        if (!password.equals(retypePassword) || password.length() < 6) {
            req.setAttribute("status", "password_error");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        // Đăng ký tài khoản
        boolean success = userDAO.registerWithEmail(email, username, password);
        if (success) {
            HttpSession session = req.getSession();
            User user = userDAO.getUserByEmail(email);
            session.setAttribute("user", user);
            resp.sendRedirect("GmailVerify.jsp");
            System.out.println("Register success.");
        } else {
            req.setAttribute("status", "register_failed");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }
}