package uploadImage;

import DAO.UserProfileDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.File;
import java.io.IOException;

@WebServlet("/upload-idcard")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 5 * 1024 * 1024,      // 5MB
        maxRequestSize = 10 * 1024 * 1024)  // 10MB
public class UploadIdCardServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();

        // Sử dụng thư mục động: /dataUpload/
        String uploadPath = getServletContext().getRealPath("/dataUpload/");
        System.out.println("Upload path thực tế: " + uploadPath);

        //  Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String idCardUrl = null;
        String idCardWithUserUrl = null;

        // Duyệt qua các phần được upload trong request
        for (Part part : request.getParts()) {
            String fieldName = part.getName();

            // Xử lý file upload cho ảnh CMND/CCCD
            if (fieldName.equals("idCardImage") && part.getSize() > 0) {
                String fileName = "idCard" + userId + ".png";
                File file = new File(uploadDir, fileName);
                part.write(file.getAbsolutePath());
                System.out.println("Đã ghi file CMND: " + file.getAbsolutePath() + " - Kích thước: " + file.length());

                // Lưu URL tương đối, dựa trên thư mục /dataUpload/
                idCardUrl = "dataUpload/" + fileName;
            }

            // Xử lý file upload cho ảnh chụp cùng CMND/CCCD
            if (fieldName.equals("idCardWithUserImage") && part.getSize() > 0) {
                String fileName = "idCardPeople" + userId + ".png";
                File file = new File(uploadDir, fileName);
                part.write(file.getAbsolutePath());
                System.out.println("Đã ghi file chụp cùng CMND: " + file.getAbsolutePath() + " - Kích thước: " + file.length());

                idCardWithUserUrl = "dataUpload/" + fileName;
            }
        }

        // Cập nhật đường dẫn file vào database
        try {
            UserProfileDAO dao = new UserProfileDAO();
            if (idCardUrl != null) dao.updateIdCardImage(userId, idCardUrl);
            if (idCardWithUserUrl != null) dao.updateIdCardWithUserImage(userId, idCardWithUserUrl);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("profile");
    }

}