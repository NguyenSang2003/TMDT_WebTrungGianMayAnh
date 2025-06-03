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

        // Đường dẫn thư mục lưu ảnh cho user, đúng với thư mục deploy
//        String uploadPath = request.getServletContext().getRealPath("/assets/images_userProfile/");
//        System.out.println("Upload path thực tế: " + uploadPath);

        // 🟩 Lấy đường dẫn thực tế tới thư mục /dataUpload/ trong webapp (tồn tại khi WAR chạy)
        String uploadPath = request.getServletContext().getRealPath("/dataUpload/");
        System.out.println("Upload path thực tế: " + uploadPath);

        //  Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String idCardUrl = null;
        String idCardWithUserUrl = null;

        for (Part part : request.getParts()) {
            String fieldName = part.getName();

            if (fieldName.equals("idCardImage") && part.getSize() > 0) {
                String fileName = "idCard" + userId + ".png";
                File file = new File(uploadPath, fileName);
                part.write(file.getAbsolutePath());
                System.out.println("✅ Đã ghi file CMND: " + file.getAbsolutePath() + " - Kích thước: " + file.length());

                // URL để truy cập (từ trình duyệt)
                idCardUrl = "dataUpload/" + fileName;
            }

            if (fieldName.equals("idCardWithUserImage") && part.getSize() > 0) {
                String fileName = "idCardPeople" + userId + ".png";
                File file = new File(uploadPath, fileName);
                part.write(file.getAbsolutePath());
                System.out.println("✅ Đã ghi file chụp cùng CMND: " + file.getAbsolutePath() + " - Kích thước: " + file.length());

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