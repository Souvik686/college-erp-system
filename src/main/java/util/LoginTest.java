package util;

import dao.UserDAO;
import model.User;

public class LoginTest {

    public static void main(String[] args) {

        UserDAO dao = new UserDAO();

        User user = dao.getUserByUsername("admin");

        if (user != null) {

            System.out.println("User Found");
            System.out.println("Username : " + user.getUsername());
            System.out.println("Role ID  : " + user.getRoleId());

        } else {

            System.out.println("User Not Found");

        }

    }

}
