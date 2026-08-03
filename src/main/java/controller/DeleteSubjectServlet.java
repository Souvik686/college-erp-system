package controller;

import dao.SubjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/DeleteSubjectServlet")
public class DeleteSubjectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int subjectId = Integer.parseInt(request.getParameter("subjectId"));

            SubjectDAO dao = new SubjectDAO();

            boolean status = dao.deleteSubject(subjectId);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/SubjectListServlet?msg=deleted");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/SubjectListServlet?error=failed");

            }

        } catch (SQLIntegrityConstraintViolationException e) {

            response.sendRedirect(request.getContextPath()
                    + "/SubjectListServlet?error=assigned");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/SubjectListServlet?error=failed");

        }

    }

}
