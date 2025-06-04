package controller;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ProductView;
import services.ProductService;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@WebServlet("/shop")
public class ShopController extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ProductView> products = productService.getAllProductViews();

        // Định dạng giá thuê theo chuẩn Việt Nam
        NumberFormat currencyFormatter = NumberFormat.getInstance(new Locale("vi", "VN"));

        // Map chứa chuỗi HTML của rating cho mỗi sản phẩm
        Map<Integer, String> ratingHtmlMap = new HashMap<>();

        for (ProductView product : products) {
            product.setFormattedPricePerDay(currencyFormatter.format(product.getPricePerDay()));

            // Tính toán số sao:
            // Lấy giá trị trung bình rating
            double avg = product.getAverageRating().doubleValue();
            int fullStars = (int) avg;
            boolean hasHalfStar = false;
            double fraction = avg - fullStars;
            if (fraction >= 0.25 && fraction < 0.75) {
                hasHalfStar = true;
            } else if (fraction >= 0.75) {
                fullStars++; // làm tròn lên nếu phần thập phân >= 0.75
            }
            int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

            // Xây dựng chuỗi HTML dựa vào số sao
            StringBuilder starHtml = new StringBuilder();
            for (int i = 0; i < fullStars; i++) {
                starHtml.append("<span class=\"star full\">&#9733;</span>");
            }
            if (hasHalfStar) {
                starHtml.append("<span class=\"star half\">&#9733;</span>");
            }
            for (int i = 0; i < emptyStars; i++) {
                starHtml.append("<span class=\"star\">&#9733;</span>");
            }

            ratingHtmlMap.put(product.getId(), starHtml.toString());
        }

        request.setAttribute("products", products);
        request.setAttribute("ratingHtmlMap", ratingHtmlMap);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }
}