package controller.admincontroller;

import DAO.UserProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.UserProfile;

import java.io.IOException;

@WebServlet("/admin/user-profile")
public class UserProfileDetailController extends HttpServlet {

    private final UserProfileDAO userProfileDAO = new UserProfileDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");

        try {
            int userId = Integer.parseInt(idStr);
            UserProfile profile = userProfileDAO.getProfileByUserId(userId);

            if (profile != null) {
                String json = String.format("""
                        {
                            "fullName": "%s",
                            "idCardNumber": "%s",
                            "address": "%s",
                            "phoneNumber": "%s",
                            "dateOfBirth": "%s",
                            "verifiedIdentity": %s,
                            "idCardImageUrl": "%s",
                            "idCardWithUserImageUrl": "%s"
                        }
                        """,
                        safe(profile.getFullName()),
                        safe(profile.getIdCardNumber()),
                        safe(profile.getAddress()),
                        safe(profile.getPhoneNumber()),
                        profile.getDateOfBirth() != null ? profile.getDateOfBirth().toString() : "",
                        profile.isVerifiedIdentity(),
                        safe(profile.getIdCardImageUrl()),
                        safe(profile.getIdCardWithUserImageUrl())
                );

                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write(json);

            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hồ sơ người dùng.");
            }

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ.");
        }
    }

    private String safe(String input) {
        return input == null ? "" : input.replace("\"", "\\\"").replace("\n", "").replace("\r", "");
    }
}
