package controller;

import DAO.BookingScheduleDAO;
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
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderItemsDAO orderItemsDAO = new OrderItemsDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final BookingScheduleDAO bookingDAO = new BookingScheduleDAO();

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

            if (user == null) {
                session.setAttribute("error", "Bạn chưa đăng nhập. Vui lòng đăng nhập để thanh toán.");
                response.sendRedirect("login.jsp");
                return;
            }

            int renterId = user.getId();

            List<ProductView> cart = (List<ProductView>) session.getAttribute("cart");
            List<Integer> createdOrderIds = new ArrayList<>();

            if (cart == null || cart.isEmpty()) {
                response.sendRedirect("cart.jsp");
                return;
            }

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

                long days = (rentEnd.getTime() - rentStart.getTime()) / (1000 * 60 * 60 * 24);
                if (days == 0) days = 1;
                else days++;

                double totalPrice = p.getPricePerDay().doubleValue() * p.getQuantity() * days;

                int ownerId = productDAO.getOwnerIdByProductId(p.getId());

                // Tạo order
                Order order = new Order();
                order.setRenterId(renterId);
                order.setOwnerId(ownerId);
                order.setStatus("cho_duyet");
                order.setRentStart(rentStart);
                order.setRentEnd(rentEnd);
                order.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                order.setUpdatedAt(new Timestamp(System.currentTimeMillis()));
                order.setTotalPrice(totalPrice);

                int orderId = orderDAO.create(order);
                if (orderId == -1) {
                    allCreated = false;
                    break;
                }

                // Tạo orderItem tương ứng
                OrderItems item = new OrderItems();
                item.setOrderId(orderId);
                item.setProductId(p.getId());
                item.setOwnerId(ownerId);
                item.setQuantity(p.getQuantity());
                item.setPricePerDay(p.getPricePerDay().doubleValue());
                item.setRentStart(rentStart);
                item.setRentEnd(rentEnd);
                item.setTotalPrice(totalPrice);

                boolean itemCreated = orderItemsDAO.createOrderItem(item);
                if (!itemCreated) {
                    allCreated = false;
                    break;
                }

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

                boolean booked = bookingDAO.createBooking(booking);
                if (!booked) {
                    allCreated = false;
                    break;
                }

                createdOrderIds.add(orderId);
            }

            if (allCreated) {
                session.removeAttribute("cart");
                session.setAttribute("createdOrderIds", createdOrderIds);

                List<OrderView> recentOrderViews = new ArrayList<>();

                for (int orderId : createdOrderIds) {
                    Order order = orderDAO.getOrderById(orderId);

                    // Lấy order items theo orderId
                    List<OrderItems> orderItemsList = orderDAO.getOrderItemsByOrderId(orderId);
                    if (orderItemsList.isEmpty()) continue;

                    OrderItems firstItem = orderItemsList.get(0); // chỉ lấy 1 item đầu tiên

                    String imageUrl = productDAO.getImageUrlByProductId(firstItem.getProductId());
                    Product product = productDAO.getProductById(firstItem.getProductId());

                    recentOrderViews.add(new OrderView(order, firstItem, imageUrl, product));
                }

                session.setAttribute("recentOrderViews", recentOrderViews);

                response.sendRedirect("checkout");
            } else {
                request.setAttribute("paymentStatus", "fail");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("paymentStatus", "fail");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

}

