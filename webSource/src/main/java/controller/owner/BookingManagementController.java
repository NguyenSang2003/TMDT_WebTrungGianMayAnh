package controller.owner;

import DAO.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BookingView;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/owner/bookings")
public class BookingManagementController extends HttpServlet {
    private BookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User owner = (User) session.getAttribute("user");

        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<BookingView> bookings = bookingDAO.getBookingViewByOwnerId(owner.getId());
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("/owner/bookingManagement.jsp").forward(req, resp);
    }
}
