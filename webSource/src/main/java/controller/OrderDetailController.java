package controller;

import DAO.OrderDAO;
import DAO.OrderItemsDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.OrderItems;
import model.Product;
import model.OrderView;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/order-detail")
public class OrderDetailController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderItemsDAO orderItemsDAO = new OrderItemsDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("idOrder");
        if (orderIdStr == null) {
            response.sendRedirect("orders");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);
        Order order = orderDAO.getOrderById(orderId);

        if (order == null) {
            response.sendRedirect("orders");
            return;
        }

        List<OrderItems> items = orderItemsDAO.getItemsByOrderId(orderId);
        List<Product> products = new ArrayList<>();
        List<String> imageUrls = new ArrayList<>();

        for (OrderItems item : items) {
            Product product = productDAO.getProductById(item.getProductId());
            String imageUrl = productDAO.getImageUrlByProductId(item.getProductId());
            products.add(product);
            imageUrls.add(imageUrl);
        }

        OrderView orderView = new OrderView(order, items, products, imageUrls);

        request.setAttribute("order", orderView);
        request.getRequestDispatcher("orderDetail.jsp").forward(request, response);
    }
}
