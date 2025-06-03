package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import services.SendMail;
import verify.VerificationCodeStore;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/resendVerification")
public class VerificationEmailController extends HttpServlet {
    // của gmailVerify đề gửi mail verify
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Bạn chưa đăng nhập.\"}");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Không tìm thấy thông tin người dùng.\"}");
            return;
        }

        String email = user.getEmail();
        String username = user.getUsername();

        if (email == null || email.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Email không hợp lệ.\"}");
            return;
        }

        Long lastSentTime = (Long) session.getAttribute("lastVerificationEmailTime");
        long now = System.currentTimeMillis();

        // Kiểm tra nếu chưa đủ 90s thì không cho gửi
        if (lastSentTime != null && now - lastSentTime < 90 * 1000) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Vui lòng chờ ít nhất 90 giây trước khi gửi lại.\"}");
            return;
        }

        // Tạo mã xác minh mới và lưu
        String code = UUID.randomUUID().toString();
        VerificationCodeStore.store(email, code);

        // Gửi email
        boolean sent = SendMail.sendVerificationEmail(email, code, username);
        if (sent) {
            session.setAttribute("lastVerificationEmailTime", now);
            response.getWriter().write("{\"status\": \"success\", \"message\": \"Mã xác minh đã được gửi tới email của bạn.\"}");
        } else {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Gửi email thất bại. Vui lòng thử lại sau.\"}");
        }
    }
}