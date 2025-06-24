package controller.owner;

import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ProductView;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/owner/oProductsManagement")
public class ProductManageController extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User owner = (User) session.getAttribute("user");

        if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        String idParam = req.getParameter("id");
        String isActiveParam = req.getParameter("isActive");

        try {
            if ("toggleActive".equals(action) && idParam != null && isActiveParam != null) {
                int id = Integer.parseInt(idParam);
                int isActive = Integer.parseInt(isActiveParam);
                productDAO.updateProductActive(id, isActive);
                resp.sendRedirect(req.getContextPath() + "/owner/oProductsManagement");
                return;
            }

            List<ProductView> products = productDAO.getProductViewsByOwnerId(owner.getId());

            // Xử lý chuyển trạng thái sang tiếng Việt
            for (ProductView p : products) {
                p.setStatusText(convertStatusToVietnamese(p.getStatus()));
            }

            req.setAttribute("products", products);
            req.getRequestDispatcher("/owner/oProductsManagement.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private String convertStatusToVietnamese(String status) {
        if (status == null) return "Không xác định";
        switch (status) {
            case "con_hang":
                return "Còn hàng";
            case "het_hang":
                return "Hết hàng";
            case "dang_cho_thue":
                return "Đang cho thuê";
            default:
                return "Không xác định";
        }
    }
}
