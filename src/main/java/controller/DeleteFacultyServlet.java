package controller;

import dao.FacultyDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/DeleteFacultyServlet")
public class DeleteFacultyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int facultyId = Integer.parseInt(request.getParameter("facultyId"));

            FacultyDAO dao = new FacultyDAO();

            boolean status = dao.deleteFaculty(facultyId);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/FacultyListServlet?msg=deleted");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/FacultyListServlet?error=failed");

            }

        } catch (SQLIntegrityConstraintViolationException e) {

            response.sendRedirect(request.getContextPath()
                    + "/FacultyListServlet?error=assigned");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/FacultyListServlet?error=failed");

        }

    }

}
