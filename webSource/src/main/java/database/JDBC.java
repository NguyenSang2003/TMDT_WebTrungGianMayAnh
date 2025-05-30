package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import utils.ConfigReader;

public class JDBC {
    private static String url = ConfigReader.getProperty("db.url");
    private static String username = ConfigReader.getProperty("db.username");
    private static String password = ConfigReader.getProperty("db.password");

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
//            System.out.println("Successfully connected to the database.");
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to connect to the database.");
        }
    }

    public static void closeConnection(Connection c) {
        try {
            if (c != null) {
                c.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    public static void main(String[] args) {
//        Connection conn = null;
//        try {
//            conn = JDBC.getConnection();
//            if (conn != null) {
//                System.out.println("Kết nối thành công đến cơ sở dữ liệu!");
//            } else {
//                System.out.println("Không thể kết nối đến cơ sở dữ liệu.");
//            }
//        } finally {
//            JDBC.closeConnection(conn);
//        }
//    }
}