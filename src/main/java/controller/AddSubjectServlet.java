package controller;

import dao.SubjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Subject;

@WebServlet("/AddSubjectServlet")
public class AddSubjectServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Subject subject = new Subject();

            subject.setSubjectCode(
                    request.getParameter("subjectCode"));

            subject.setSubjectName(
                    request.getParameter("subjectName"));

            subject.setDepartmentId(
                    Integer.parseInt(request.getParameter("departmentId")));

            subject.setSemester(
                    Integer.parseInt(request.getParameter("semester")));

            SubjectDAO subjectDAO = new SubjectDAO();

            boolean status = subjectDAO.addSubject(subject);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/SubjectListServlet");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/jsp/add-subject.jsp?error=failed");

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/jsp/add-subject.jsp?error=exception");

        }

    }

}
