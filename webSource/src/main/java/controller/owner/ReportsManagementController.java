package controller.owner;

import DAO.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ReportView;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/owner/reports")
public class ReportsManagementController extends HttpServlet {
    private ReportDAO reportDAO;

    @Override
    public void init() {
        reportDAO = new ReportDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User owner = (User) session.getAttribute("user");

        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<ReportView> list = reportDAO.getReportsByOwnerId(owner.getId());
        req.setAttribute("reports", list);
        req.getRequestDispatcher("/owner/reportsManagement.jsp").forward(req, resp);
    }
}
