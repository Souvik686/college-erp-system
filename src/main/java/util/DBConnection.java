package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = System.getenv().getOrDefault(
        "DB_URL", "jdbc:mysql://localhost:3306/college_erp");
    private static final String USER = System.getenv().getOrDefault(
        "DB_USER", "root");
    private static final String PASSWORD = System.getenv().getOrDefault(
        "DB_PASSWORD", "student123");

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
