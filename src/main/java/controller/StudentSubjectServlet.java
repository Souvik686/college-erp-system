package controller;

import dao.StudentDAO;
import dao.SubjectDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import model.Student;
import model.User;

@WebServlet("/StudentSubjectServlet")
public class StudentSubjectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("user") == null) {

                response.sendRedirect(request.getContextPath() + "/jsp/student-login.jsp");
                return;

            }

            User user = (User) session.getAttribute("user");

            int userId = user.getUserId();

            StudentDAO studentDAO = new StudentDAO();

            int studentId = studentDAO.getStudentIdByUserId(userId);

            Student student = studentDAO.getStudentById(studentId);

            SubjectDAO subjectDAO = new SubjectDAO();

            request.setAttribute(
                    "subjectList",
                    subjectDAO.getSubjectsByDepartmentSemester(
                            student.getDepartmentId(),
                            student.getSemester()));

            request.getRequestDispatcher("/jsp/student-subject.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println("Error : " + e.getMessage());

        }

    }

}
