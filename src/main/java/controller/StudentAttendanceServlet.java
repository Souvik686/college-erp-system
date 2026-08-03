package controller;

import dao.AttendanceDAO;
import dao.StudentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import model.User;

@WebServlet("/StudentAttendanceServlet")
public class StudentAttendanceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("user") == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/jsp/student-login.jsp");
                return;

            }

            User user = (User) session.getAttribute("user");

            StudentDAO studentDAO = new StudentDAO();

            int studentId = studentDAO.getStudentIdByUserId(user.getUserId());

            AttendanceDAO attendanceDAO = new AttendanceDAO();

            request.setAttribute(
                    "attendanceList",
                    attendanceDAO.getAttendanceByStudentWithDetails(studentId));

            request.getRequestDispatcher("/jsp/student-attendance.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(e.getMessage());

        }

    }

}
