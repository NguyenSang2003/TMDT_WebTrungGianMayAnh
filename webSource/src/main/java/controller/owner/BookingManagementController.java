package controller.owner;

import DAO.BookingDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
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

        List<BookingView> list = bookingDAO.getBookingViewsByOwnerId(owner.getId());
        req.setAttribute("bookingList", list);
        req.getRequestDispatcher("/owner/bookingManagement.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User owner = (User) session.getAttribute("user");

        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));

        boolean success = false;

        if ("approve".equals(action)) {
            success = bookingDAO.updateStatus(bookingId, "xac_nhan", owner.getId());
        } else if ("cancel".equals(action)) {
            success = bookingDAO.updateStatus(bookingId, "huy", owner.getId());
        } else if ("pending".equals(action)) {
            success = bookingDAO.updateStatus(bookingId, "cho_duyet", owner.getId());
        } else if ("delete".equals(action)) {
            success = bookingDAO.deleteBooking(bookingId, owner.getId());
        }

        resp.sendRedirect(req.getContextPath() + "/owner/bookings");
    }
}
