package controller;

import DAO.OrderDAO;
import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private ProductDAO productDAO = new ProductDAO();

    // Hiển thị trang checkout
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<OrderView> recentOrderViews = (List<OrderView>) session.getAttribute("recentOrderViews");

        if (recentOrderViews != null) {
            request.setAttribute("recentOrderViews", recentOrderViews);
        }
        request.getRequestDispatcher("checkout.jsp").forward(request, response);

    }

    // Tạo đơn hàng
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            // ✅ Nếu chưa đăng nhập, chuyển hướng về trang login và hiển thị thông báo
            if (user == null) {
                session.setAttribute("error", "Bạn chưa đăng nhập. Vui lòng đăng nhập để thanh toán.");
                response.sendRedirect("login.jsp");
                return;
            }

            int renterId = user.getId();

            List<ProductView> cart = (List<ProductView>) session.getAttribute("cart");
            List<Integer> createdOrderIds = new ArrayList<>();

            // Kiểm tra giỏ hàng trống
            if (cart == null || cart.isEmpty()) {
                // Có thể chuyển hướng đến trang giỏ hàng hoặc thông báo lỗi
                response.sendRedirect("cart.jsp"); // Hoặc một trang lỗi thích hợp
                return;
            }

            // Lấy ngày thuê từ từng sản phẩm (do mỗi sản phẩm chọn ngày riêng)
            Map<Integer, Date[]> rentDates = new HashMap<>();

            for (ProductView p : cart) {
                String rentStartStr = request.getParameter("rentStart_" + p.getId());
                String rentEndStr = request.getParameter("rentEnd_" + p.getId());

                if (rentStartStr == null || rentEndStr == null || rentStartStr.isEmpty() || rentEndStr.isEmpty()) {
                    request.setAttribute("paymentStatusTime", "failTime");
                    request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    return;
                }

                try {
                    Date rentStart = Date.valueOf(rentStartStr);
                    Date rentEnd = Date.valueOf(rentEndStr);

                    if (rentStart.after(rentEnd)) {
                        request.setAttribute("paymentStatusTime", "failTime");
                        request.getRequestDispatcher("checkout.jsp").forward(request, response);
                        return;
                    }

                    rentDates.put(p.getId(), new Date[]{rentStart, rentEnd});
                } catch (IllegalArgumentException e) {
                    request.setAttribute("paymentStatusTime", "failTime");
                    request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    return;
                }
            }

            boolean allCreated = true;
            for (ProductView p : cart) {
                Date rentStart = rentDates.get(p.getId())[0];
                Date rentEnd = rentDates.get(p.getId())[1];

                // Tính số ngày thuê
                // Nếu là cùng ngày, days = 0, nhưng thuê 1 ngày nên set days = 1
                long days = (rentEnd.getTime() - rentStart.getTime()) / (1000 * 60 * 60 * 24);
                if (days == 0) days = 1; // nếu cùng ngày => 1 ngày
                else days++; // nếu nhiều ngày => tính cả ngày cuối

                double totalPrice = p.getPricePerDay().doubleValue() * p.getQuantity() * days;

                int ownerId = productDAO.getOwnerIdByProductId(p.getId());

                Order order = new Order();
                order.setRenterId(renterId);
                order.setOwnerId(ownerId);
                order.setProductId(p.getId());
                order.setQuantity(p.getQuantity());
                order.setTotalPrice(totalPrice);
                order.setStatus("cho_duyet");
                order.setRentStart(rentStart);
                order.setRentEnd(rentEnd);
                order.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                order.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

                int orderId = orderDAO.create(order);
                if (orderId == -1) {
                    allCreated = false;
                    break;
                }

                createdOrderIds.add(orderId);

                // Tạo booking schedule
                BookingSchedule booking = new BookingSchedule();
                booking.setProductId(p.getId());
                booking.setRenterId(renterId);
                booking.setOwnerId(ownerId);
                booking.setOrderId(orderId);
                booking.setRentStart(rentStart);
                booking.setRentEnd(rentEnd);
                booking.setStatus("cho_duyet");
                booking.setCreatedAt(order.getCreatedAt());
                booking.setUpdatedAt(order.getUpdatedAt());

                boolean booked = orderDAO.createBooking(booking); // Bạn cần implement DAO này
                if (!booked) {
                    allCreated = false;
                    // Lời khuyên: Nếu booking schedule thất bại, bạn nên rollback order đã tạo
                    // Để làm được điều này, cần sử dụng Transaction Management.
                    break;
                }
            }

            if (allCreated) {
                session.removeAttribute("cart");
                session.setAttribute("createdOrderIds", createdOrderIds); // ✅ lưu lại orderId

                List<OrderView> recentOrderViews = new ArrayList<>();

                for (int orderId : createdOrderIds) {
                    Order order = orderDAO.getOrderById(orderId); // cần implement trong OrderDAO

                    int productId = order.getProductId();
                    String imageUrl = productDAO.getImageUrlByProductId(productId); // cần implement trong ProductDAO
                    Product product = productDAO.getProductById(productId);

                    recentOrderViews.add(new OrderView(order, imageUrl, product));
                }

                session.setAttribute("recentOrderViews", recentOrderViews);

                response.sendRedirect("checkout");
            } else {
                response.sendRedirect("checkout.jsp");
            }


        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("paymentStatus", "fail");
            request.getRequestDispatcher("checkout").forward(request, response);
        }
    }
}

