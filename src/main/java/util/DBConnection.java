package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        if (url == null || url.trim().isEmpty()) {
            url = "jdbc:mysql://gateway01.ap-southeast-1.prod.aws.tidbcloud.com:4000/college_erp?useSSL=true&serverTimezone=UTC";
        }
        if (user == null || user.trim().isEmpty()) {
            user = "4CmAy49sGjswZos.root";
        }
        if (password == null || password.trim().isEmpty() || password.equals("student123")) {
            password = "MAJbzUXy7aUzMJS2";
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("=== DB CONNECTION FAILED ===");
            System.err.println("Attempted URL: " + url);
            System.err.println("Attempted USER: " + user);
            System.err.println("Error Message: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
