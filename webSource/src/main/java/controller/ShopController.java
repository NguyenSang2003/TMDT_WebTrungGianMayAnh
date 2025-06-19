package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductView;
import services.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet("/shop")
public class ShopController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách sản phẩm để hiển thị trên shop
            List<ProductView> productViews = productService.getAllProducts();
            request.setAttribute("productViews", productViews);

            // Forward về trang shop.jsp
            request.getRequestDispatcher("shop.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải sản phẩm.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
