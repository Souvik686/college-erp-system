package controller;

import dao.FacultyDAO;
import dao.SubjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Subject;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/FacultySubjectServlet")
public class FacultySubjectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/faculty-login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleId() != 2) {
            response.sendRedirect(request.getContextPath() + "/jsp/faculty-login.jsp");
            return;
        }

        FacultyDAO facultyDAO = new FacultyDAO();

        int facultyId = facultyDAO.getFacultyIdByUserId(user.getUserId());

        SubjectDAO subjectDAO = new SubjectDAO();

        List<Subject> list = subjectDAO.getSubjectsByFaculty(facultyId);

        request.setAttribute("subjectList", list);

        request.getRequestDispatcher("/jsp/faculty-subjects.jsp")
                .forward(request, response);
    }
}
