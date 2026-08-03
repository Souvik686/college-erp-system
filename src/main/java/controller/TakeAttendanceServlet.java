package controller;

import dao.FacultyDAO;
import dao.StudentDAO;
import dao.SubjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Subject;
import model.User;

@WebServlet("/TakeAttendanceServlet")
public class TakeAttendanceServlet extends HttpServlet {

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

        List<Subject> subjectList = subjectDAO.getSubjectsByFaculty(facultyId);

        request.setAttribute("subjects", subjectList);

        String subjectId = request.getParameter("subjectId");

        if (subjectId != null && !subjectId.isEmpty()) {

            Subject subject = subjectDAO.getSubjectById(Integer.parseInt(subjectId));

            StudentDAO studentDAO = new StudentDAO();

            request.setAttribute("students",
                    studentDAO.getStudentsByDepartmentAndSemester(
                            subject.getDepartmentId(),
                            subject.getSemester()));

            request.setAttribute("selectedSubject", subject);

        }

        request.getRequestDispatcher("/jsp/take-attendance.jsp")
                .forward(request, response);

    }

}
