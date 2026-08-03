package controller;

import dao.FacultyDAO;
import dao.SubjectDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import model.Subject;

@WebServlet("/EditSubjectServlet")
public class EditSubjectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        SubjectDAO subjectDAO = new SubjectDAO();
        FacultyDAO facultyDAO = new FacultyDAO();

        Subject subject = subjectDAO.getSubjectById(id);

        request.setAttribute("subject", subject);

        request.setAttribute(
                "facultyList",
                facultyDAO.getAllFaculty());

        request.setAttribute(
                "assignedFaculty",
                facultyDAO.getAssignedFacultyIds(id));

        request.getRequestDispatcher("/jsp/edit-subject.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Subject subject = new Subject();

        subject.setSubjectId(
                Integer.parseInt(request.getParameter("subjectId")));

        subject.setSubjectCode(
                request.getParameter("subjectCode"));

        subject.setSubjectName(
                request.getParameter("subjectName"));

        subject.setDepartmentId(
                Integer.parseInt(request.getParameter("departmentId")));

        subject.setSemester(
                Integer.parseInt(request.getParameter("semester")));

        SubjectDAO subjectDAO = new SubjectDAO();

        subjectDAO.updateSubject(subject);

        String[] facultyIds
                = request.getParameterValues("facultyIds");

        FacultyDAO facultyDAO = new FacultyDAO();

        facultyDAO.updateFacultySubjects(
                subject.getSubjectId(),
                facultyIds);

        response.sendRedirect(
                request.getContextPath()
                + "/SubjectListServlet");

    }

}
