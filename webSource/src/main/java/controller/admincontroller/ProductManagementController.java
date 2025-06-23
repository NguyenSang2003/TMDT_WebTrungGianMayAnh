package controller.admincontroller;



import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.ProductDetail;
import model.ProductView;
import services.ProductService;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/admin/productsManagement")
public class ProductManagementController extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final ProductDAO productDAO = new ProductDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<ProductView> productList = productService.getAllProductsforAdmin();

        // Đưa vào request attribute để chuyển sang trang JSP
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("/admin/aProductsManagement.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String idStr = req.getParameter("id");

        Product product = new Product();
        ProductDetail detail = new ProductDetail();

        // --- Gán cho Product ---
        product.setName(req.getParameter("name"));
        product.setPricePerDay(new BigDecimal(req.getParameter("pricePerDay").replace(",", "")));
        String createdAtStr = req.getParameter("created_at").replace("T", " ") + ":00";
        product.setCreatedAt(Timestamp.valueOf(createdAtStr));
        product.setQuantity(Integer.parseInt(req.getParameter("quantity")));
        // sau khi gọp code sẽ sửa lại
        product.setUserId(1);   // Tạm hardcode
        product.setStatus(req.getParameter("status"));
        // --- Gán cho ProductDetail ---
        detail.setBrand(req.getParameter("brand"));
        detail.setImageUrl(req.getParameter("imageUrl"));
        detail.setCategory(req.getParameter("category"));
        detail.setModel(req.getParameter("model"));
        detail.setColor(req.getParameter("color"));
        detail.setWeight(new BigDecimal(req.getParameter("weight").replace(",", "")));
        detail.setDescription(req.getParameter("description"));

        boolean success;
        if (idStr == null || idStr.isEmpty()) {
            success = productDAO.addProduct(
                    product,
                    detail.getBrand(), detail.getImageUrl(),
                    detail.getCategory(), detail.getModel(),
                    detail.getColor(), detail.getWeight(),
                    detail.getDescription()
            );
        } else {
            product.setId(Integer.parseInt(idStr));
            success = productDAO.updateProduct(product, detail);
        }

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/productsManagement");
        } else {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Thao tác thất bại.");
        }
    }

}
