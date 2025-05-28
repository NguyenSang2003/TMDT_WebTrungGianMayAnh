package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import java.io.IOException;

@WebFilter("/*")
public class VerifyEmailFilter implements Filter {

    private static final Set<String> STATIC_PATH_PREFIXES = new HashSet<>(Arrays.asList(
            "/css/", "/js/", "/images/", "/assets/", "/adminAssets/"
    ));

    private static final Set<String> PUBLIC_PATHS = new HashSet<>(Arrays.asList(
            "/login.jsp", "/register.jsp", "/forgot-password.jsp", "/reset-password.jsp",
            "/logout", "/index", "/shop", "/resendVerification", "/verify"
    ));

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getServletPath();
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Bỏ qua tài nguyên tĩnh
        for (String prefix : STATIC_PATH_PREFIXES) {
            if (path.startsWith(prefix)) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Bỏ qua các path public
        if (PUBLIC_PATHS.contains(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Truy cập GmailVerify.jsp mà chưa login → về login.jsp
        if (path.equals("/GmailVerify.jsp") && user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Đã login nhưng chưa xác thực → buộc verify
        if (user != null && !user.isVerifyEmail() && !path.equals("/GmailVerify.jsp")) {
            resp.sendRedirect(req.getContextPath() + "/GmailVerify.jsp");
            return;
        }

        // Tất cả hợp lệ → tiếp tục
        chain.doFilter(request, response);
    }
}