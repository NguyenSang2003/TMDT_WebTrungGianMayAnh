package controller.owner;

import DAO.WithdrawalDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.Withdrawal;

import java.io.IOException;
import java.util.List;

@WebServlet("/owner/withdrawalManagement")
public class WithdrawalManagementController extends HttpServlet {
    private WithdrawalDAO dao = new WithdrawalDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null || !"nguoi_cho_thue".equals(user.getRole())) {
            resp.sendRedirect("../login.jsp");
            return;
        }
        List<Withdrawal> withdrawalList = dao.getWithdrawalsByOwner(user.getId());
        req.setAttribute("withdrawalList", withdrawalList);
        req.getRequestDispatcher("withdrawalManagement.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}