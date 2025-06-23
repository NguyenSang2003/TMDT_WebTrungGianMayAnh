package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import model.ProductDetail;
import model.ProductView;
import services.ProductDetailService;
import services.ProductService;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

@WebServlet("/product-detail")
public class ProductDetailController extends HttpServlet {

    private final ProductService productService = new ProductService();
    private final ProductDetailService productDetailService = new ProductDetailService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy id sản phẩm từ query string (?id=...)
            int productId = Integer.parseInt(request.getParameter("id"));

            // Lấy thông tin sản phẩm (gồm cả view count, tên, giá, v.v.)
            ProductView product = productService.getProductViewById(productId);

            // Lấy thông tin chi tiết sản phẩm (brand, color, accessories, ...)
            ProductDetail detail = productDetailService.getProductDetailByProductId(productId);

            // kiểm tra xem sản phẩm có tồn tại ko ?
            if (product == null || detail == null) {
                request.setAttribute("notFound", true);
                request.getRequestDispatcher("/productDetail.jsp").forward(request, response);
                return;
            }

            // Lấy thông tin các sản phẩm liên quan
            List<ProductView> relatedProducts = productService.getRelatedProducts(product.getId(), detail.getCategory(), 3);

            // Định dạng giá thuê theo chuẩn Việt Nam (dùng dấu chấm ngăn cách hàng nghìn)
            NumberFormat currencyFormatter = NumberFormat.getInstance(new Locale("vi", "VN"));
            product.setFormattedPricePerDay(currencyFormatter.format(product.getPricePerDay()));

            // Chuyển trạng thái sang tiếng Việt để hiển thị ra view
            String displayStatus;
            switch (product.getStatus()) {
                case "con_hang":
                    displayStatus = "còn hàng";
                    break;
                case "het_hang":
                    displayStatus = "hết hàng";
                    break;
                case "dang_cho_thue":
                    displayStatus = "đang cho thuê";
                    break;
                default:
                    displayStatus = product.getStatus(); // fallback nếu không khớp
            }

            // Truyền dữ liệu sang JSP
            if (product != null && detail != null) {
                request.setAttribute("product", product);           // Đối tượng sản phẩm (ProductView)
                request.setAttribute("detail", detail);             // Chi tiết sản phẩm (ProductDetail)
                request.setAttribute("displayStatus", displayStatus); // Trạng thái dạng tiếng Việt
                request.setAttribute("relatedProducts", relatedProducts); //Các sản phẩm liên quan

//                System.out.println("product: " + product);
//                System.out.println("detail: " + detail);
//                System.out.println("displayStatus: " + displayStatus);

                // Gửi sang trang JSP để hiển thị
                request.getRequestDispatcher("/productDetail.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy sản phẩm, trả về lỗi 404
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm");
            }

        } catch (NumberFormatException e) {
            // Nếu ID truyền vào không hợp lệ (không phải số),
            request.setAttribute("invalidId", true);
            request.getRequestDispatcher("/productDetail.jsp").forward(request, response);
        }
    }
}