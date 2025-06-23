package controller.admincontroller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class UserController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String role = req.getParameter("role");
        String activeStr = req.getParameter("active");
        String keyword = req.getParameter("keyword");

        Boolean isActive = null;
        if (activeStr != null && !activeStr.isEmpty()) {
            isActive = Boolean.parseBoolean(activeStr);
        }

        List<User> users = userDAO.searchUsers(keyword, role, isActive);

        req.setAttribute("selectedRole", role);
        req.setAttribute("selectedActive", activeStr);
        req.setAttribute("searchKeyword", keyword);
        req.setAttribute("userList", users);
        req.getRequestDispatcher("/admin/userManagement.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        String idStr = req.getParameter("id");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(idStr);
            userDAO.deleteUser(id);
        } else {
            User user = new User();
            user.setUsername(req.getParameter("username"));
            user.setEmail(req.getParameter("email"));
            user.setRole(req.getParameter("role"));
            user.setVerifyEmail(Boolean.parseBoolean(req.getParameter("isVerifyEmail")));
            user.setActive(Boolean.parseBoolean(req.getParameter("isActive")));

            if ("add".equals(action)) {
                user.setPassword("123456"); // hoặc yêu cầu nhập
                userDAO.addUser(user);
            } else if ("update".equals(action)) {
                user.setId(Integer.parseInt(idStr));
                userDAO.updateUser(user);
            } else if ("toggle_active".equals(action)) {
            int id = Integer.parseInt(idStr);
            int currentStatus = Integer.parseInt(req.getParameter("currentStatus"));
            boolean newStatus = currentStatus == 1 ? false : true;
            userDAO.updateUserActiveStatus(id, newStatus);
        }

    }
        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}

