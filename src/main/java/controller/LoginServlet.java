package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;
import util.BCryptUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        int expectedRole = Integer.parseInt(request.getParameter("expectedRole"));

        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsername(username);

        String context = request.getContextPath();

        if (user != null
                && BCryptUtil.checkPassword(password, user.getPassword())
                && user.getRoleId() == expectedRole) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60);

            switch (user.getRoleId()) {

                case 1:
                    response.sendRedirect(context + "/AdminDashboardServlet");
                    break;

                case 2:
                    response.sendRedirect(context + "/jsp/faculty-dashboard.jsp");
                    break;

                case 3:
                    response.sendRedirect(context + "/jsp/student-dashboard.jsp");
                    break;

                default:
                    response.sendRedirect(context + "/");
                    break;
            }

        } else {

            switch (expectedRole) {

                case 1:
                    response.sendRedirect(context + "/jsp/admin-login.jsp?error=1");
                    System.out.println("Entered Password : " + password);

                    if (user != null) {
                        System.out.println("DB Password : " + user.getPassword());
                        System.out.println("Password Match : "
                                + BCryptUtil.checkPassword(password, user.getPassword()));
                    }
                    break;

                case 2:
                    response.sendRedirect(context + "/jsp/faculty-login.jsp?error=1");
                    break;

                case 3:
                    response.sendRedirect(context + "/jsp/student-login.jsp?error=1");
                    break;

                default:
                    response.sendRedirect(context + "/");
                    break;
            }
        }
    }
}
