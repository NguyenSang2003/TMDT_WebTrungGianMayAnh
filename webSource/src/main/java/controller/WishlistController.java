package controller;

import DAO.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductView;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistController extends HttpServlet {
    private WishlistDAO wishlistDAO = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<ProductView> wishlist = wishlistDAO.getWishlistByUserId(user.getId());
        req.setAttribute("wishlist", wishlist);
        req.getRequestDispatcher("wishList.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int productId = Integer.parseInt(req.getParameter("productId"));
        boolean isAddWishList = wishlistDAO.addToWishlist(user.getId(), productId);

        if (isAddWishList) {
            System.out.println("add product " + productId + " to wishlist success.");
        } else {
            System.out.println("add product " + productId + " to wishlist failed.");
        }

        String referer = req.getHeader("referer");
        resp.sendRedirect(referer != null ? referer : "index");
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        int productId = Integer.parseInt(req.getParameter("productId"));
        boolean result = wishlistDAO.removeFromWishlist(user.getId(), productId);
        if (result) {
            System.out.println("delete product " + productId + " out of wishlist success.");
            resp.setStatus(HttpServletResponse.SC_OK);
        } else {
            System.out.println("delete product " + productId + " out of wishlist success.");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}