package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebFilter("/admins/*") // Áp dụng cho tất cả URL bắt đầu bằng /admin/
public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // Nếu không đăng nhập hoặc không phải admin → redirect về index
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        // Nếu là admin → cho phép tiếp tục
        chain.doFilter(request, response);
    }
}
