package controller.owner;

import DAO.UserProfileDAO;
import DAO.WithdrawalDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.UserProfile;
import model.WithdrawalView;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/owner/withdrawalManagement")
public class WithdrawalManagementController extends HttpServlet {

    WithdrawalDAO withdrawalDAO = new WithdrawalDAO();
    UserProfileDAO profileDAO = new UserProfileDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User owner = (User) req.getSession().getAttribute("user");
        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<WithdrawalView> paidOrders = withdrawalDAO.getWithdrawalViewByOwnerId(owner.getId());
        BigDecimal totalRevenue = withdrawalDAO.getTotalPaidRevenue(owner.getId());

        List<WithdrawalView> pendingRequests = (List<WithdrawalView>) req.getSession().getAttribute("withdrawalPending");
        List<WithdrawalView> successRequests = (List<WithdrawalView>) req.getSession().getAttribute("withdrawalSuccess");

        if (pendingRequests == null) pendingRequests = new ArrayList<>();
        if (successRequests == null) successRequests = new ArrayList<>();

        BigDecimal totalRequested = pendingRequests.stream().map(WithdrawalView::getAmount).reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal availableToWithdraw = totalRevenue.subtract(totalRequested);

        UserProfile profile = profileDAO.getProfileByUserId(owner.getId());
        req.setAttribute("ownerProfile", profile);

        req.setAttribute("paidOrders", paidOrders);
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("totalRequested", totalRequested);
        req.setAttribute("availableToWithdraw", availableToWithdraw);
        req.setAttribute("withdrawalRequests", pendingRequests);
        req.setAttribute("withdrawalHistorySuccess", successRequests);

        req.getRequestDispatcher("/owner/withdrawalManagement.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User owner = (User) req.getSession().getAttribute("user");
        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<WithdrawalView> pendingRequests = (List<WithdrawalView>) req.getSession().getAttribute("withdrawalPending");
        if (pendingRequests == null) pendingRequests = new ArrayList<>();

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            BigDecimal amount = new BigDecimal(req.getParameter("amount"));
            WithdrawalView w = new WithdrawalView();
            w.setAmount(amount);
            w.setOrderId((int) (System.currentTimeMillis() % 100000));
            w.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
            pendingRequests.add(w);
        } else if ("edit".equals(action)) {
            int requestId = Integer.parseInt(req.getParameter("id"));
            BigDecimal amount = new BigDecimal(req.getParameter("amount"));
            for (WithdrawalView w : pendingRequests) {
                if (w.getOrderId() == requestId) {
                    w.setAmount(amount);
                    break;
                }
            }
        } else if ("delete".equals(action)) {
            int requestId = Integer.parseInt(req.getParameter("id"));
            pendingRequests.removeIf(w -> w.getOrderId() == requestId);
        }

        req.getSession().setAttribute("withdrawalPending", pendingRequests);
        resp.sendRedirect(req.getContextPath() + "/owner/withdrawalManagement");
    }
}
