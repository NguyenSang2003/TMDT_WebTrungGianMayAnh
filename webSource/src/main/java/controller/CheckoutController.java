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

            // Gom sản phẩm theo owner
            Map<Integer, List<ProductView>> productsByOwner = new HashMap<>();
            for (ProductView p : cart) {
                int ownerId = productDAO.getOwnerIdByProductId(p.getId());
                productsByOwner.computeIfAbsent(ownerId, k -> new ArrayList<>()).add(p);
            }

            boolean allCreated = true;

            for (Map.Entry<Integer, List<ProductView>> entry : productsByOwner.entrySet()) {
                int ownerId = entry.getKey();
                List<ProductView> productList = entry.getValue();

                double totalPrice = 0;
                Timestamp now = new Timestamp(System.currentTimeMillis());

                // Tính tổng tiền của cả đơn hàng
                for (ProductView p : productList) {
                    Date rentStart = rentDates.get(p.getId())[0];
                    Date rentEnd = rentDates.get(p.getId())[1];
                    long days = (rentEnd.getTime() - rentStart.getTime()) / (1000 * 60 * 60 * 24);
                    if (days == 0) days = 1;
                    else days++;
                    totalPrice += p.getPricePerDay().doubleValue() * p.getQuantity() * days;
                }

                // Dùng thời gian thuê của sản phẩm đầu tiên làm mốc
                Date rentStart = rentDates.get(productList.get(0).getId())[0];
                Date rentEnd = rentDates.get(productList.get(0).getId())[1];

                // Tạo đơn hàng
                Order order = new Order();
                order.setRenterId(renterId);
                order.setOwnerId(ownerId);
                order.setTotalPrice(totalPrice);
                order.setStatus("cho_duyet");
                order.setRentStart(rentStart);
                order.setRentEnd(rentEnd);
                order.setCreatedAt(now);
                order.setUpdatedAt(now);

                int orderId = orderDAO.create(order);
                if (orderId == -1) {
                    allCreated = false;
                    break;
                }

                for (ProductView p : productList) {
                    Date pStart = rentDates.get(p.getId())[0];
                    Date pEnd = rentDates.get(p.getId())[1];

                    long days = (pEnd.getTime() - pStart.getTime()) / (1000 * 60 * 60 * 24);
                    if (days == 0) days = 1;
                    else days++;

                    double itemTotal = p.getPricePerDay().doubleValue() * p.getQuantity() * days;

                    // OrderItem
                    OrderItems item = new OrderItems();
                    item.setOrderId(orderId);
                    item.setProductId(p.getId());
                    item.setOwnerId(ownerId);
                    item.setQuantity(p.getQuantity());
                    item.setPricePerDay(p.getPricePerDay().doubleValue());
                    item.setRentStart(pStart);
                    item.setRentEnd(pEnd);
                    item.setTotalPrice(itemTotal);

                    boolean itemCreated = orderItemsDAO.createOrderItem(item);
                    if (!itemCreated) {
                        allCreated = false;
                        break;
                    }

                    // BookingSchedule
                    BookingSchedule booking = new BookingSchedule();
                    booking.setProductId(p.getId());
                    booking.setRenterId(renterId);
                    booking.setOwnerId(ownerId);
                    booking.setOrderId(orderId);
                    booking.setRentStart(pStart);
                    booking.setRentEnd(pEnd);
                    booking.setStatus("cho_duyet");
                    booking.setCreatedAt(now);
                    booking.setUpdatedAt(now);

                    boolean booked = bookingDAO.createBooking(booking);
                    if (!booked) {
                        allCreated = false;
                        break;
                    }
                }

                createdOrderIds.add(orderId);
            }

            if (allCreated) {
                session.removeAttribute("cart");
                session.setAttribute("createdOrderIds", createdOrderIds);

                // Gửi recentOrderViews cho checkout.jsp
                List<OrderView> recentOrderViews = new ArrayList<>();
                for (int orderId : createdOrderIds) {
                    Order order = orderDAO.getOrderById(orderId);
                    List<OrderItems> items = orderDAO.getOrderItemsByOrderId(orderId);

                    List<Product> products = new ArrayList<>();
                    List<String> imageUrls = new ArrayList<>();
                    for (OrderItems item : items) {
                        Product product = productDAO.getProductById(item.getProductId());
                        String img = productDAO.getImageUrlByProductId(item.getProductId());
                        products.add(product);
                        imageUrls.add(img);
                    }

                    recentOrderViews.add(new OrderView(order, items, products, imageUrls));
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

