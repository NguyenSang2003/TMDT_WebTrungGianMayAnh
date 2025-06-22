package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutController", value = "/logout")
public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
//        session.invalidate(); // Xóa toàn bộ session

        session.removeAttribute("user");
        session.removeAttribute("userName");
        session.removeAttribute("user_id");

        // Logout khỏi Google luôn
        String logoutGoogleUrl = "https://accounts.google.com/Logout?continue="
                + "https://appengine.google.com/_ah/logout?continue="
                + "http://localhost:8080/webSource_war/login.jsp";

        System.out.println("Logout success");

        response.sendRedirect("login.jsp");
    }
}
