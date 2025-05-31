package utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigReader {
    private static final Properties properties = new Properties();

    static {
        loadProperties("properties.env");
        loadProperties("dp.properties"); // ưu tiên ghi đè nếu trùng key
    }

    private static void loadProperties(String fileName) {
        try (InputStream inputStream = ConfigReader.class.getClassLoader().getResourceAsStream(fileName)) {
            if (inputStream != null) {
                Properties temp = new Properties();
                temp.load(inputStream);
                properties.putAll(temp);
                System.out.println("Đã tải file: " + fileName);
            } else {
                System.err.println("Không tìm thấy file: " + fileName);
            }
        } catch (IOException e) {
            System.err.println("Lỗi khi đọc file: " + fileName);
            e.printStackTrace();
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
}
