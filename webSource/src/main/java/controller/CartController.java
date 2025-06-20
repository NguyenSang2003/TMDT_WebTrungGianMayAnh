package controller;

import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BookingSchedule;
import model.ProductView;

import java.io.IOException;
import java.util.*;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Lấy cart từ session, nếu không có thì tạo mới
        List<ProductView> cart = (List<ProductView>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Lấy booking schedules cho từng sản phẩm trong cart
        for (ProductView pv : cart) {
            if (pv != null) {
                List<BookingSchedule> bookings = productDAO.getBookingsByProductId(pv.getId());

                // Đảm bảo không trả về null mà là danh sách rỗng nếu không có booking
                if (bookings == null) {
                    bookings = new ArrayList<>();
                }
                pv.setBookingSchedules(bookings);
            }
        }

        // Cập nhật cart vào request để JSP dùng
        request.setAttribute("cart", cart);

        // Chuyển tiếp đến cart.jsp để hiển thị giỏ hàng
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        List<ProductView> cart = (List<ProductView>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        if ("add".equals(action)) {

            int productId;
            try {
                productId = Integer.parseInt(request.getParameter("productId"));
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID sản phẩm không hợp lệ");
                return;
            }

            System.out.println(">>> Nhận productId: " + productId);
            boolean found = false;

            for (ProductView item : cart) {
                if (item.getId() == productId) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    System.out.println(">>> Tăng số lượng sản phẩm trong giỏ hàng");
                    break;
                }
            }

            if (!found) {
                System.out.println(">>> Sản phẩm chưa có trong giỏ, thêm mới");
                ProductView product = productDAO.getProductViewById(productId);
                if (product != null) {
//                    System.out.println("=== Product data ===");
//                    System.out.println("ID: " + product.getId());
//                    System.out.println("Name: " + product.getName());
//                    System.out.println("UserId: " + product.getUserId());
//                    System.out.println("PricePerDay: " + product.getPricePerDay());
//                    System.out.println("Quantity: " + product.getQuantity());
//                    System.out.println("Status: " + product.getStatus());
//                    System.out.println("CreatedAt: " + product.getCreatedAt());
//                    System.out.println("UpdatedAt: " + product.getUpdatedAt());
//                    System.out.println("ViewCount: " + product.getViewCount());
//                    System.out.println("SoldCount: " + product.getSoldCount());
//                    System.out.println("Rating: " + product.getRating());
//                    System.out.println("ImageUrl: " + product.getImageUrl());
//                    System.out.println("Category: " + product.getCategory());
                    product.setQuantity(1);
                    cart.add(product);
                    System.out.println(">>> Thêm sản phẩm: " + product.getName());
                } else {
                    System.out.println(">>> Không tìm thấy sản phẩm với ID: " + productId);
//                    System.out.println("=== Product data ===");
//                    System.out.println("Name: " + product.getName());
//                    System.out.println("UserId: " + product.getUserId());
//                    System.out.println("PricePerDay: " + product.getPricePerDay());
//                    System.out.println("Quantity: " + product.getQuantity());
//                    System.out.println("Status: " + product.getStatus());
//                    System.out.println("CreatedAt: " + product.getCreatedAt());
//                    System.out.println("UpdatedAt: " + product.getUpdatedAt());
//                    System.out.println("ViewCount: " + product.getViewCount());
//                    System.out.println("SoldCount: " + product.getSoldCount());
//                    System.out.println("Rating: " + product.getRating());
//                    System.out.println("ImageUrl: " + product.getImageUrl());
//                    System.out.println("Category: " + product.getCategory());
                    // Bạn có thể set status lỗi ở đây để backend trả lỗi
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Không tìm thấy sản phẩm");
                    return; // Dừng xử lý, không redirect
                }
            }

            session.setAttribute("cart", cart);
            System.out.println(">>> Cập nhật giỏ hàng vào session thành công, redirect về cart");

            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"message\": \"Đã thêm vào giỏ hàng thành công\"}");
            } else {
                response.sendRedirect("cart");
            }

        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeIf(p -> p.getId() == productId);
            session.setAttribute("cart", cart);
            response.sendRedirect("cart");

        } else if ("updateQuantity".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String operation = request.getParameter("operation");

            Iterator<ProductView> iterator = cart.iterator();
            while (iterator.hasNext()) {
                ProductView item = iterator.next();
                if (item.getId() == productId) {
                    if ("increase".equals(operation)) {
                        item.setQuantity(item.getQuantity() + 1);
                    } else if ("decrease".equals(operation)) {
                        int newQuantity = item.getQuantity() - 1;
                        if (newQuantity > 0) {
                            item.setQuantity(newQuantity);
                        } else {
                            iterator.remove(); // an toàn hơn khi xóa trong vòng lặp
                        }
                    }
                    break;
                }
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("cart");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
