package controller.owner;

import DAO.RevenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;
import java.util.Map;

@WebServlet("/owner/oRevenueReport")
public class RevenueReportController extends HttpServlet {
    private RevenueDAO dao = new RevenueDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        Map<String, Double> revenueMap = dao.getRevenueByProduct(user.getId());
        req.setAttribute("revenueMap", revenueMap);
        req.getRequestDispatcher("oRevenueReport.jsp").forward(req, resp);
    }

@Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }
}