package controller;

import dao.DepartmentDAO;
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
import model.User;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
            return;

        }

        User user = (User) session.getAttribute("user");

        if (user.getRoleId() != 1) {

            response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
            return;

        }

        StudentDAO studentDAO = new StudentDAO();
        FacultyDAO facultyDAO = new FacultyDAO();
        DepartmentDAO departmentDAO = new DepartmentDAO();
        SubjectDAO subjectDAO = new SubjectDAO();

        request.setAttribute("studentCount", studentDAO.getStudentCount());
        request.setAttribute("facultyCount", facultyDAO.getFacultyCount());
        request.setAttribute("departmentCount", departmentDAO.getDepartmentCount());
        request.setAttribute("subjectCount", subjectDAO.getSubjectCount());

        request.getRequestDispatcher("/jsp/admin-dashboard.jsp")
                .forward(request, response);

    }

}
