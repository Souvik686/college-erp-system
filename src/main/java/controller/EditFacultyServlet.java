package controller;

import dao.FacultyDAO;
import dao.FacultySubjectDAO;
import dao.SubjectDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/EditFacultyServlet")
public class EditFacultyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int facultyId = Integer.parseInt(request.getParameter("facultyId"));

            FacultyDAO facultyDAO = new FacultyDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            FacultySubjectDAO facultySubjectDAO = new FacultySubjectDAO();

            request.setAttribute("faculty",
                    facultyDAO.getFacultyById(facultyId));

            request.setAttribute("subjectList",
                    subjectDAO.getAllSubjects());

            request.setAttribute("assignedSubjects",
                    facultySubjectDAO.getAssignedSubjects(facultyId));

            request.getRequestDispatcher("/jsp/edit-faculty.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/FacultyListServlet");

        }

    }

}
