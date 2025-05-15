package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter({"/login.jsp", "/register.jsp", "/forgotPass.jsp"})
// Áp dụng filter cho các trang đăng nhập, đăng ký, quên mật khẩu
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Nếu session có user (người dùng đã đăng nhập), chuyển hướng về trang chủ
        if (session != null && session.getAttribute("user") != null) {
            httpResponse.sendRedirect("index.jsp");
            return;
        }

        // Nếu không có user trong session, cho phép tiếp tục xử lý request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Dọn dẹp nếu cần
    }
}
