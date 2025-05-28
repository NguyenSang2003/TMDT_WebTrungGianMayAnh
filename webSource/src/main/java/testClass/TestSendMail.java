package testClass;

import services.SendMail;

public class TestSendMail {
    public static void main(String[] args) {
        String email = "kevinwebb2812@gmail.com";

        // Test gửi mật khẩu mới
        String newPassword = generateRandomPassword();
        boolean newPasswordSent = SendMail.sendNewPasswordEmail(email, newPassword, "testusser");
        if (newPasswordSent) {
            System.out.println("✅ Gửi email mật khẩu mới thành công tới: " + email);
            System.out.println("Mật khẩu mới: " + newPassword);
        } else {
            System.out.println("❌ Gửi email mật khẩu mới thất bại.");
        }

        // Test gửi email xác minh
        String verificationCode = generateRandomCode();
        boolean verificationSent = SendMail.sendVerificationEmail(email, verificationCode, "TestUser");
        if (verificationSent) {
            System.out.println("✅ Gửi email xác minh thành công tới: " + email);
            System.out.println("Mã xác minh (dùng để test): " + verificationCode);
        } else {
            System.out.println("❌ Gửi email xác minh thất bại.");
        }
    }

    // Tạo mật khẩu ngẫu nhiên (8 ký tự)
    public static String generateRandomPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            int index = (int) (Math.random() * chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }

    // Tạo mã xác minh ngẫu nhiên 6 chữ số
    public static String generateRandomCode() {
        int code = (int) (Math.random() * 900000) + 100000;
        return String.valueOf(code);
    }
}