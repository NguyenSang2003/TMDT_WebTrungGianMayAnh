package controller;

import DAO.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import model.ProductView;

import java.io.IOException;
import java.util.*;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy giỏ hàng từ session
        HttpSession session = request.getSession();
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        request.setAttribute("cart", cart); // đẩy sang JSP
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
                ProductView product = cartDAO.getProductById(productId);
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
