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
=======
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

        // ✅ Check wishlist if user is logged in
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
