package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import utils.ConfigReader;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "GoogleLogin", value = "/google-login")
public class GoogleLoginController extends HttpServlet {

    private static final String CLIENT_ID = ConfigReader.getProperty("GOOGLE_CLIENT_ID");
    private static final String CLIENT_SECRET = ConfigReader.getProperty("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI = ConfigReader.getProperty("GOOGLE_REDIRECT_URI");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        // B1: Lấy access token từ Google
        String tokenUrl = "https://oauth2.googleapis.com/token";
        String tokenPayload = "code=" + code +
                "&client_id=" + CLIENT_ID +
                "&client_secret=" + CLIENT_SECRET +
                "&redirect_uri=" + REDIRECT_URI +
                "&grant_type=authorization_code";

        String tokenResponse = postURL(tokenUrl, tokenPayload);
        String accessToken = extract(tokenResponse, "access_token");

        // B2: Lấy thông tin người dùng từ Google
        String infoUrl = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=" + accessToken;
        String userInfo = readURL(infoUrl);

        String sub = extract(userInfo, "sub");
        String email = extract(userInfo, "email");

        if (email == null || email.isEmpty()) {
            email = sub + "@googleuser.com";
        }

        // B3: Kiểm tra và xử lý tài khoản
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            String username = email.split("@")[0];
            String password = UUID.randomUUID().toString();

            // Đăng ký user mới
            boolean success = userDAO.registerWithEmail(email, username, password);

            if (!success) {
                response.sendRedirect("login.jsp?error=register_failed");
                return;
            }

            // Cập nhật trạng thái xác thực email
            userDAO.markEmailVerified(email);
            user = userDAO.getUserByEmail(email);
        }

        // B4: Tạo session
        HttpSession session = request.getSession();
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("user", user);

        response.sendRedirect("index");
    }

    private String postURL(String urlStr, String urlParams) throws IOException {
        java.net.URL url = new java.net.URL(urlStr);
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        try (java.io.OutputStream os = conn.getOutputStream()) {
            os.write(urlParams.getBytes());
        }

        try (java.util.Scanner scanner = new java.util.Scanner(conn.getInputStream(), "UTF-8")) {
            return scanner.useDelimiter("\\A").next();
        }
    }

    private String readURL(String urlStr) throws IOException {
        java.net.URL url = new java.net.URL(urlStr);
        try (java.util.Scanner scanner = new java.util.Scanner(url.openStream(), "UTF-8")) {
            return scanner.useDelimiter("\\A").next();
        }
    }

    private String extract(String json, String key) {
        String pattern = "\"" + key + "\"\\s*:\\s*\"([^\"]+)\"";
        java.util.regex.Matcher matcher = java.util.regex.Pattern.compile(pattern).matcher(json);
        return matcher.find() ? matcher.group(1) : null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Not used
    }
}
