package controller.admincontroller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
@WebServlet("/admin/toggleUserActive")
public class ToggleUserActiveController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        int newStatus = Integer.parseInt(req.getParameter("status")); // 0 or 1
        boolean isActive = newStatus == 1;

        boolean result = userDAO.updateUserActiveStatus(id, isActive);

        if (result) {
            resp.setStatus(HttpServletResponse.SC_OK);
        } else {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}


