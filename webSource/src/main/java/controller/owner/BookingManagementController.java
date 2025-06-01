package controller.owner;

import DAO.BookingDAO;
import model.BookingSchedule;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/owner/bookingManagement")
public class BookingManagementController extends HttpServlet {
    private BookingDAO dao = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<BookingSchedule> bookingList = dao.getAllBookings();
        request.setAttribute("bookingList", bookingList);
        request.getRequestDispatcher("bookingManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookingId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        dao.updateBookingStatus(bookingId, status);
        response.sendRedirect("bookingManagement");
    }
}
