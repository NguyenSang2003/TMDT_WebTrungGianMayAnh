package controller;

import DAO.OrderDAO;
import DAO.OrderItemsDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orders")
public class OrdersController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderItemsDAO orderItemsDAO = new OrderItemsDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Order> userOrders = orderDAO.getOrdersByUserId(userId);
        List<OrderView> orderViews = new ArrayList<>();

        for (Order order : userOrders) {
            List<OrderItems> items = orderItemsDAO.getItemsByOrderId(order.getId());

            if (items.isEmpty()) continue;

            List<Product> products = new ArrayList<>();
            List<String> imageUrls = new ArrayList<>();

            for (OrderItems item : items) {
                Product product = productDAO.getProductById(item.getProductId());
                String imageUrl = productDAO.getImageUrlByProductId(item.getProductId());

                products.add(product);
                imageUrls.add(imageUrl);
            }

            // Dùng constructor đầy đủ
            OrderView orderView = new OrderView(order, items, products, imageUrls);
            orderViews.add(orderView);
        }

        request.setAttribute("orders", orderViews);
        request.getRequestDispatcher("/orders.jsp").forward(request, response);
    }

    // Xử lý hủy đơn hàng
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (user == null || !"khach_thue".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"status\":\"error\", \"message\":\"Bạn cần đăng nhập để thực hiện chức năng này.\"}");
            return;
        }

        String orderIdParam = request.getParameter("orderId");

        if (orderIdParam != null) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                Order order = orderDAO.getOrderById(orderId);

                if (order != null && order.getRenterId() == user.getId() && "cho_duyet".equals(order.getStatus())) {
                    order.setStatus("huy");
                    order.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
                    boolean success = orderDAO.updateOrderStatus(order);

                    if (success) {
                        out.print("{\"status\":\"success\", \"message\":\"Đã hủy đơn hàng thành công!\"}");
                    } else {
                        out.print("{\"status\":\"error\", \"message\":\"Không thể hủy đơn hàng lúc này.\"}");
                    }
                } else {
                    out.print("{\"status\":\"error\", \"message\":\"Không thể hủy đơn hàng.\"}");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                out.print("{\"status\":\"error\", \"message\":\"Dữ liệu không hợp lệ.\"}");
            }
        } else {
            out.print("{\"status\":\"error\", \"message\":\"Thiếu mã đơn hàng.\"}");
        }
    }

}