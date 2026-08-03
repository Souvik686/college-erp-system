package controller;

import dao.StudentDAO;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

import model.Student;
import model.User;
import util.DBConnection;

@WebServlet("/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = null;

        try {

            con = DBConnection.getConnection();
            con.setAutoCommit(false);
            
            // User Details
            
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            User user = new User();

            user.setUsername(username);
            user.setPassword(password);
            user.setRoleId(3);
            user.setStatus("ACTIVE");

            UserDAO userDAO = new UserDAO();

            int userId = userDAO.createUser(con, user);

            if (userId == 0) {

                throw new Exception("Failed to create user.");

            }

            // Student Details
            
            Student student = new Student();

            student.setUserId(userId);
            student.setDepartmentId(
                    Integer.parseInt(request.getParameter("departmentId")));
            student.setRollNo(request.getParameter("rollNo"));
            student.setName(request.getParameter("name"));
            student.setEmail(request.getParameter("email"));
            student.setPhone(request.getParameter("phone"));
            student.setSemester(
                    Integer.parseInt(request.getParameter("semester")));

            StudentDAO studentDAO = new StudentDAO();

            boolean status = studentDAO.addStudent(con, student);

            if (!status) {

                throw new Exception("Failed to create student.");

            }

            // Commit Transaction
            
            con.commit();

            response.sendRedirect(
                    request.getContextPath()
                    + "/StudentListServlet?success=added");

        } catch (Exception e) {

            try {

                if (con != null) {

                    con.rollback();

                }

            } catch (Exception ex) {

                ex.printStackTrace();

            }

            String message = e.getMessage();

            if (message != null) {

                message = message.toLowerCase();

                if (message.contains("username")) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/jsp/add-student.jsp?error=username");
                    return;

                } else if (message.contains("email")) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/jsp/add-student.jsp?error=email");
                    return;

                } else if (message.contains("roll")) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/jsp/add-student.jsp?error=roll");
                    return;

                } else {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/jsp/add-student.jsp?error=failed");
                    return;

                }

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/jsp/add-student.jsp?error=failed");
                return;

            }

        } finally {

            try {

                if (con != null) {

                    con.setAutoCommit(true);
                    con.close();

                }

            } catch (Exception e) {

                e.printStackTrace();

            }

        }

    }

}
