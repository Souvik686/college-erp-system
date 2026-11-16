<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Diagnostic</title>
    <style>
        body { font-family: sans-serif; padding: 30px; background: #f0f2f5; }
        .card { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 800px; margin: auto; }
        .status-ok { color: #27ae60; font-weight: bold; font-size: 18px; }
        .status-err { color: #e74c3c; font-weight: bold; font-size: 18px; }
        pre { background: #2c3e50; color: #ecf0f1; padding: 15px; border-radius: 6px; overflow-x: auto; font-size: 13px; }
        .badge { background: #3498db; color: white; padding: 3px 8px; border-radius: 4px; font-size: 12px; }
    </style>
</head>
<body>
<div class="card">
    <h2>Database Connection Diagnostic</h2>
    <hr/>
    <p><strong>DB_URL:</strong> 
        <%= System.getenv("DB_URL") != null ? "<span class='badge'>" + System.getenv("DB_URL") + "</span>" : "<span class='status-err'>NOT SET (null)</span>" %>
    </p>
    <p><strong>DB_USER:</strong> 
        <%= System.getenv("DB_USER") != null ? "<span class='badge'>" + System.getenv("DB_USER") + "</span>" : "<span class='status-err'>NOT SET (null)</span>" %>
    </p>
    <p><strong>DB_PASSWORD set?</strong> 
        <%= System.getenv("DB_PASSWORD") != null ? "<span class='status-ok'>YES (" + System.getenv("DB_PASSWORD").length() + " chars)</span>" : "<span class='status-err'>NO</span>" %>
    </p>
    <hr/>
    <h3>Connection Test Result</h3>
    <%
        String url = System.getenv("DB_URL");
        String user = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");
        
        if (url == null || url.trim().isEmpty()) url = "jdbc:mysql://gateway01.ap-southeast-1.prod.aws.tidbcloud.com:4000/college_erp?useSSL=true&serverTimezone=UTC";
        if (user == null || user.trim().isEmpty()) user = "4CmAy49sGjswZos.root";
        if (password == null || password.trim().isEmpty() || password.equals("student123")) password = "MAJbzUXy7aUzMJS2";

        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, password);
    %>
            <p class="status-ok"> Connection Successful!</p>
    <%
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT count(*) FROM users");
            if (rs.next()) {
    %>
                <p>Users in database: <strong><%= rs.getInt(1) %></strong></p>
    <%
            }
            rs.close();
            
            ResultSet rs2 = st.executeQuery("SELECT user_id, username, role_id FROM users LIMIT 5");
    %>
            <h4>Sample Users:</h4>
            <ul>
    <%
            while (rs2.next()) {
    %>
                <li>ID: <%= rs2.getInt("user_id") %> | Username: <strong><%= rs2.getString("username") %></strong> | Role: <%= rs2.getInt("role_id") %></li>
    <%
            }
            rs2.close();
            st.close();
    %>
            </ul>
    <%
        } catch (Throwable t) {
    %>
            <p class="status-err"> Connection Failed!</p>
            <p><strong>Error Type:</strong> <%= t.getClass().getName() %></p>
            <p><strong>Message:</strong> <%= t.getMessage() %></p>
            <pre><%
                java.io.StringWriter sw = new java.io.StringWriter();
                java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                t.printStackTrace(pw);
                out.print(sw.toString());
            %></pre>
    <%
        } finally {
            if (con != null) { try { con.close(); } catch (Exception ignored) {} }
        }
    %>
</div>
</body>
</html>
