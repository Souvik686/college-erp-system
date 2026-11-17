package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Opens JDBC connections to the college_erp database.
 *
 * Connection details come from environment variables so no credentials live in
 * the source code:
 *
 *   DB_URL       e.g. jdbc:mysql://localhost:3306/college_erp
 *   DB_USER      database user
 *   DB_PASSWORD  database password
 *
 * When DB_URL / DB_USER are not set, the defaults below target a local MySQL
 * server for development. Production (Render) must set all three variables.
 */
public class DBConnection {

    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/college_erp";
    private static final String DEFAULT_USER = "root";

    public static Connection getConnection() {
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        if (url == null || url.trim().isEmpty()) {
            url = DEFAULT_URL;
        }
        if (user == null || user.trim().isEmpty()) {
            user = DEFAULT_USER;
        }
        if (password == null) {
            password = "";
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("=== DB CONNECTION FAILED ===");
            System.err.println("Attempted URL: " + url);
            System.err.println("Attempted USER: " + user);
            System.err.println("Error Message: " + e.getMessage());
            System.err.println("Check that DB_URL, DB_USER and DB_PASSWORD are set correctly.");
            e.printStackTrace();
        }
        return null;
    }
}
