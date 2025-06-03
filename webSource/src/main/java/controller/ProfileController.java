package controller;

import jakarta.servlet.http.HttpServlet;

import java.text.SimpleDateFormat;

import DAO.UserProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import model.UserProfile;
import model.UserView;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private final UserProfileDAO profileDAO = new UserProfileDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Lấy thông tin hồ sơ
        UserProfile profile = profileDAO.getProfileByUserId(user.getId());
        if (profile == null) {
            profileDAO.createEmptyProfileForUser(user.getId());
            profile = profileDAO.getProfileByUserId(user.getId());
        }

        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy");
        String formattedCreatedAt = user.getCreatedAt() != null ? formatter.format(user.getCreatedAt()) : "Không có";
        String formattedUpdatedAt = user.getUpdatedAt() != null ? formatter.format(user.getUpdatedAt()) : "Không có";

        // Chuyển role sang tiếng Việt để hiển thị ra view
        String displayRole;
        switch (user.getRole()) {
            case "nguoi_cho_thue":
                displayRole = "Người cho thuê";
                break;
            case "khach_thue":
                displayRole = "Khách thuê";
                break;
            case "admin":
                displayRole = "Quản trị hệ thống";
                break;
            default:
                displayRole = user.getRole(); // fallback nếu không khớp
        }

        UserView view = new UserView();
        view.setUser(user);
        view.setUserProfile(profile);

        System.out.println("Get user profile data success");

        req.setAttribute("userView", view);
        req.setAttribute("displayRole", displayRole);
        req.setAttribute("createdAtFormatted", formattedCreatedAt);
        req.setAttribute("updatedAtFormatted", formattedUpdatedAt);

        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String fullName = req.getParameter("fullName");
        String idCardNumber = req.getParameter("idCardNumber");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String dobStr = req.getParameter("dob");

        Date dob = dobStr != null && !dobStr.isEmpty() ? Date.valueOf(dobStr) : null;

        UserProfile profile = new UserProfile();
        profile.setUserId(user.getId());
        profile.setFullName(fullName);
        profile.setIdCardNumber(idCardNumber);
        profile.setAddress(address);
        profile.setPhoneNumber(phone);
        profile.setDateOfBirth(dob);

        profileDAO.updateProfile(profile);

        System.out.println("update userProfile success");

        resp.sendRedirect("profile");
    }

}
