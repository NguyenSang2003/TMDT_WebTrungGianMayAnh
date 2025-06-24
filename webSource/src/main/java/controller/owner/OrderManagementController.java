package controller.owner;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.OrderListView;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/owner/orders")
public class OrderManagementController extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User owner = (User) session.getAttribute("user");

        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<OrderListView> orders = orderDAO.getOrdersByOwnerId(owner.getId());
        req.setAttribute("orderList", orders);
        req.getRequestDispatcher("/owner/oOdersManagement.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User owner = (User) session.getAttribute("user");

        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        int orderId = Integer.parseInt(req.getParameter("orderId"));

        if ("approve".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "dang_thue", owner.getId());
        } else if ("cancel".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "huy", owner.getId());
        }

        resp.sendRedirect(req.getContextPath() + "/owner/orders");
    }
}
