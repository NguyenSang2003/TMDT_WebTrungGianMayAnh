package controller.admincontroller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import services.ProductService;

import java.io.IOException;

@WebServlet("/admin/toggleActive")
public class ToggleProductActiveController extends HttpServlet {
    private final ProductService productService = new ProductService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        int status = Integer.parseInt(req.getParameter("status"));

        productService.updateActiveStatus(id, status);
        resp.setStatus(HttpServletResponse.SC_OK); // 200
    }
}
