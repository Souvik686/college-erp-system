package controller;

import dao.AttendanceDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/DeleteAttendanceServlet")
public class DeleteAttendanceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String id = request.getParameter("attendanceId");

            if (id != null && !id.isEmpty()) {

                int attendanceId = Integer.parseInt(id);

                AttendanceDAO attendanceDAO = new AttendanceDAO();

                attendanceDAO.deleteAttendance(attendanceId);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        response.sendRedirect(request.getContextPath() + "/AttendanceListServlet");

    }

}
