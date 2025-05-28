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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("status", "failed");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(email, password);

        if (user == null) {
            req.setAttribute("status", "failed");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userName", user.getUsername());
        session.setMaxInactiveInterval(10 * 60);// Session tồn tại trong 10 phút

        System.out.println("Login success");

        if ("admin".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect("admin/ordersManagement.jsp");
        } else {
            resp.sendRedirect("index");
        }
    }

}