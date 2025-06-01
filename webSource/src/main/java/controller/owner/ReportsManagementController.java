package controller.owner;

import DAO.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Report;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/owner/reportsManagement")
public class ReportsManagementController extends HttpServlet {
    private ReportDAO dao = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        List<Report> reportList = dao.getReportsByOwner(user.getId());
        req.setAttribute("reportList", reportList);
        req.getRequestDispatcher("reportsManagement.jsp").forward(req, resp);
    }
@Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { } 
}