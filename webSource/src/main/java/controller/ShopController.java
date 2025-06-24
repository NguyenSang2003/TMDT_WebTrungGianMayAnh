package controller;

import DAO.WishlistDAO;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProductView;
import model.User;
import services.ProductService;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.*;

@WebServlet("/shop")
public class ShopController extends HttpServlet {
    private ProductService productService = new ProductService();
    private WishlistDAO wishlistDAO = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String category = request.getParameter("category");

        List<ProductView> products;

        // Nếu có ít nhất một tiêu chí lọc (keyword, brand, model, category) được nhập
        if ((keyword != null && !keyword.trim().isEmpty()) ||
                (brand != null && !brand.trim().isEmpty()) ||
                (model != null && !model.trim().isEmpty()) ||
                (category != null && !category.trim().isEmpty())) {

            products = productService.searchAndFilterProducts(keyword, brand, model, category);
        } else {
            products = productService.getAllProductViews();
        }

        // Định dạng giá thuê theo chuẩn Việt Nam
        NumberFormat currencyFormatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        Map<Integer, String> ratingHtmlMap = new HashMap<>();

        for (ProductView product : products) {
            product.setFormattedPricePerDay(currencyFormatter.format(product.getPricePerDay()));

            // Tính toán số sao từ averageRating
            double avg = product.getAverageRating().doubleValue();
            int fullStars = (int) avg;
            boolean hasHalfStar = false;
            double fraction = avg - fullStars;
            if (fraction >= 0.25 && fraction < 0.75) {
                hasHalfStar = true;
            } else if (fraction >= 0.75) {
                fullStars++;
            }
            int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

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

        // Kiểm tra wishlist nếu user đã đăng nhập
        HttpSession session = request.getSession(false);
        Set<Integer> wishlistIds = new HashSet<>();
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                List<ProductView> wishlist = wishlistDAO.getWishlistByUserId(user.getId());
                for (ProductView p : wishlist) {
                    wishlistIds.add(p.getId());
                }
            }
        }

        request.setAttribute("products", products);
        request.setAttribute("ratingHtmlMap", ratingHtmlMap);
        request.setAttribute("wishlistIds", wishlistIds);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }
}