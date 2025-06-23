package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.ProductService;
import model.ProductView;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

import DAO.WishlistDAO;
import model.User;

import java.util.*;

@WebServlet("/index")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductService();
    private WishlistDAO wishlistDAO = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Lấy danh sách sản phẩm theo từng loại có tích hợp thông tin chi tiết (hình ảnh)
        List<ProductView> latestProducts = productService.getLatestProductsWithDetails();
        List<ProductView> bestSellingProducts = productService.getBestSellingProductsWithDetails();
        List<ProductView> mostViewedProducts = productService.getMostViewedProductsWithDetails();

//        System.out.println("Latest Products: " + latestProducts.size());
//        System.out.println("Best Selling Products: " + bestSellingProducts.size());
//        System.out.println("Most Viewed Products: " + mostViewedProducts.size());

        // Định dạng giá tiền thành "1.000.000"
        NumberFormat currencyFormatter = NumberFormat.getInstance(new Locale("vi", "VN"));

        for (ProductView p : latestProducts) {
            p.setFormattedPricePerDay(currencyFormatter.format(p.getPricePerDay()));
        }

        for (ProductView p : bestSellingProducts) {
            p.setFormattedPricePerDay(currencyFormatter.format(p.getPricePerDay()));
        }

        for (ProductView p : mostViewedProducts) {
            p.setFormattedPricePerDay(currencyFormatter.format(p.getPricePerDay()));
        }

        // ✅ Wishlist check
        HttpSession session = req.getSession(false);
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

        // Đưa vào request attribute để chuyển sang trang JSP
        req.setAttribute("latestProducts", latestProducts);
        req.setAttribute("bestSellingProducts", bestSellingProducts);
        req.setAttribute("mostViewedProducts", mostViewedProducts);
        req.setAttribute("wishlistIds", wishlistIds);

        // Forward sang trang index.jsp
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}