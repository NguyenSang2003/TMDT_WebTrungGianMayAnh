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



@WebServlet("/aProductsManagement")
public class ProductManagementController extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final ProductDAO productDAO = new ProductDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<ProductView> productList = productService.getAllProducts();
        System.out.println("Product list size: " + productList.size());
        for (ProductView p : productList) {
            System.out.println(p.getId() + " - " + p.getName() + " - " + p.getPricePerDay() + " - " + p.getBrand() +" - "+ p.getQuantity() );
        }
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
    product.setName(req.getParameter("name"));
    product.setPricePerDay(new BigDecimal(req.getParameter("pricePerDay")));
    product.setStatus(req.getParameter("status"));
    String createdAtStr = req.getParameter("created_at").replace("T", " ") + ":00";
    product.setCreatedAt(Timestamp.valueOf(createdAtStr));
    product.setQuantity(Integer.parseInt(req.getParameter("quantity")));
    product.setUserId(1);   // Tạm hardcode hoặc lấy từ session

    String brand = req.getParameter("brand");
    String imageUrl = req.getParameter("imageUrl");

    boolean success;
    if (idStr == null || idStr.isEmpty()) {
        success = productDAO.addProduct(product, brand, imageUrl);
    } else {
        product.setId(Integer.parseInt(idStr));
        success = productDAO.updateProduct(product);
    }


    if (success) {
        resp.sendRedirect(req.getContextPath() + "/aProductsManagement");
    } else {
        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Thao tác thất bại.");
    }
}


}
