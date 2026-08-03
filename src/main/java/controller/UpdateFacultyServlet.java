package controller;

import dao.FacultyDAO;
import dao.FacultySubjectDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import model.Faculty;

@WebServlet("/UpdateFacultyServlet")
public class UpdateFacultyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Faculty faculty = new Faculty();

            faculty.setFacultyId(
                    Integer.parseInt(request.getParameter("facultyId")));

            faculty.setFacultyName(
                    request.getParameter("facultyName"));

            faculty.setEmail(
                    request.getParameter("email"));

            faculty.setPhone(
                    request.getParameter("phone"));

            FacultyDAO facultyDAO = new FacultyDAO();

            boolean status = facultyDAO.updateFaculty(faculty);

            if (status) {

                FacultySubjectDAO dao = new FacultySubjectDAO();

                int facultyId = faculty.getFacultyId();

                dao.deleteAssignments(facultyId);

                String[] subjectIds = request.getParameterValues("subjectIds");

                if (subjectIds != null) {

                    for (String id : subjectIds) {

                        dao.assignSubject(
                                facultyId,
                                Integer.parseInt(id));

                    }

                }

                response.sendRedirect(
                        request.getContextPath()
                        + "/FacultyListServlet");

            } else {

                response.getWriter().println("Update Failed");

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}
