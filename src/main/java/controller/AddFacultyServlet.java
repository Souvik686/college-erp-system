package controller;

import dao.FacultyDAO;
import dao.FacultySubjectDAO;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import model.Faculty;
import model.User;
import java.sql.Connection;
import util.DBConnection;

@WebServlet("/AddFacultyServlet")
public class AddFacultyServlet extends HttpServlet {

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
            user.setRoleId(2);
            user.setStatus("ACTIVE");

            UserDAO userDAO = new UserDAO();

            int userId = userDAO.createUser(con, user);

            if (userId == 0) {

                response.sendRedirect(request.getContextPath()
                        + "/jsp/add-faculty.jsp?error=user");

                return;
            }
            
            // Faculty Details
            
            Faculty faculty = new Faculty();

            faculty.setUserId(userId);

            faculty.setDepartmentId(
                    Integer.parseInt(request.getParameter("departmentId")));

            faculty.setFacultyName(
                    request.getParameter("facultyName"));

            faculty.setEmail(
                    request.getParameter("email"));

            faculty.setPhone(
                    request.getParameter("phone"));

            FacultyDAO facultyDAO = new FacultyDAO();

            boolean status = facultyDAO.addFaculty(con, faculty);

            if (!status) {

                response.sendRedirect(request.getContextPath()
                        + "/jsp/add-faculty.jsp?error=faculty");

                return;
            }
            
            // Assign Subjects
            
            int facultyId = facultyDAO.getFacultyIdByUserId(con, userId);

            String[] subjectIds = request.getParameterValues("subjectIds");

            FacultySubjectDAO facultySubjectDAO = new FacultySubjectDAO();

            if (subjectIds != null) {

                for (String subjectId : subjectIds) {

                    facultySubjectDAO.assignSubject(
                            con,
                            facultyId,
                            Integer.parseInt(subjectId));

                }

            }
            con.commit();

            response.sendRedirect(
                    request.getContextPath()
                    + "/FacultyListServlet?success=added");
            return;

        } catch (Exception e) {

            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception ex) {
                ex.printStackTrace();
            }

            String message = e.getMessage();

            if (message != null && message.contains("users.username")) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/jsp/add-faculty.jsp?error=username");
                return;

            } else if (message != null && message.contains("uk_faculty_email")) {

                request.getSession().setAttribute(
                        "facultyError",
                        "Faculty email already exists.");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/jsp/add-faculty.jsp?error=failed");
                return;

            }

            response.sendRedirect(request.getContextPath()
                    + "/jsp/add-faculty.jsp");
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
