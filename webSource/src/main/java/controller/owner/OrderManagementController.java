package controller.owner;

import DAO.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/owner/oOdersManagement")
public class OrderManagementController extends HttpServlet {
    private OrderDAO dao = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        List<Order> orderList = dao.getOrdersByOwner(user.getId());
        req.setAttribute("orderList", orderList);
        req.getRequestDispatcher("oOdersManagement.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}