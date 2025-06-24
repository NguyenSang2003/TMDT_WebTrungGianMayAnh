package controller.owner;

import DAO.RevenueDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.RevenueReportView;
import model.User;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/owner/oRevenueReport")
public class RevenueReportController extends HttpServlet {
    private final RevenueDAO dao = new RevenueDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int ownerId = ((User) req.getSession().getAttribute("user")).getId();
        String fromStr = req.getParameter("from");
        String toStr = req.getParameter("to");

        // Luôn truyền ngược giá trị đã chọn về JSP để form giữ nguyên
        req.setAttribute("fromDate", fromStr);
        req.setAttribute("toDate", toStr);

        if (fromStr == null || toStr == null || fromStr.isEmpty() || toStr.isEmpty()) {
            req.getRequestDispatcher("/owner/oRevenueReport.jsp").forward(req, resp);
            return;
        }

        Date from = Date.valueOf(fromStr);
        Date to = Date.valueOf(toStr);

        List<RevenueReportView> list = dao.getRevenueByOwnerAndTime(ownerId, from, to);
        req.setAttribute("revenueList", list);

        req.setAttribute("totalRevenue", dao.getTotalRevenue(ownerId, from, to));
        req.getRequestDispatcher("/owner/oRevenueReport.jsp").forward(req, resp);
    }
}