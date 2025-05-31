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
            int productId = Integer.parseInt(request.getParameter("productId"));
            boolean found = false;

            for (ProductView item : cart) {
                if (item.getId() == productId) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }

            if (!found) {
                ProductView product = productDAO.getProductViewById(productId);
                if (product != null) {
                    product.setQuantity(1); // Đặt mặc định là 1
                    cart.add(product);
                }
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("cart");

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
