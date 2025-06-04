package controller;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ProductView;
import services.ProductService;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

@WebServlet("/shop")
public class ShopController extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ProductView> products = productService.getAllProductViews();

        // Định dạng giá thuê theo chuẩn Việt Nam
        NumberFormat currencyFormatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        for (ProductView product : products) {
            product.setFormattedPricePerDay(currencyFormatter.format(product.getPricePerDay()));
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }
}
