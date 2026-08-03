package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.User;
import util.DBConnection;
import util.BCryptUtil;

public class UserDAO {

    public User getUserByUsername(String username) {

        User user = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE username=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRoleId(rs.getInt("role_id"));
                user.setStatus(rs.getString("status"));

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return user;

    }

    public int createUser(Connection con, User user) throws Exception {

        int userId = 0;

        String sql = "INSERT INTO users(username,password,role_id,status) VALUES(?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setString(1, user.getUsername());
        ps.setString(2, BCryptUtil.hashPassword(user.getPassword()));
        ps.setInt(3, user.getRoleId());
        ps.setString(4, user.getStatus());

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();

        if (rs.next()) {
            userId = rs.getInt(1);
        }

        rs.close();
        ps.close();

        return userId;
    }

    public int createUser(User user) {

        int userId = 0;

        try {

            Connection con = DBConnection.getConnection();
            System.out.println("Connection = " + con);

            String sql = "INSERT INTO users(username,password,role_id,status) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            System.out.println("Username = " + user.getUsername());
            System.out.println("Role = " + user.getRoleId());
            System.out.println("Status = " + user.getStatus());

            ps.setString(1, user.getUsername());
            ps.setString(2, BCryptUtil.hashPassword(user.getPassword()));
            ps.setInt(3, user.getRoleId());
            ps.setString(4, user.getStatus());

            int rows = ps.executeUpdate();

            System.out.println("Rows = " + rows);

            ResultSet rs = ps.getGeneratedKeys();

            if (rs.next()) {
                userId = rs.getInt(1);
                System.out.println("Generated ID = " + userId);
            } else {
                System.out.println("NO GENERATED KEY");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            System.out.println("createUser() ERROR:");
            e.printStackTrace();

        }

        return userId;
    }

}
