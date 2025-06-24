package controller.admincontroller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/change-role")
public class ChangeRoleController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        String newRole = req.getParameter("role");

        boolean success = false;
        try {
            int id = Integer.parseInt(idStr);
            success = userDAO.updateUserRole(id, newRole);
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.getWriter().write("{\"success\": " + success + "}");
    }
}
