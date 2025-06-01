package controller.owner;

import DAO.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingSchedule;

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
