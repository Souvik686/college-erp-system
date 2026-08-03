package controller;

import dao.AttendanceDAO;
import dao.DepartmentDAO;
import dao.SubjectDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AttendanceListServlet")
public class AttendanceListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        AttendanceDAO attendanceDAO = new AttendanceDAO();
        DepartmentDAO departmentDAO = new DepartmentDAO();
        SubjectDAO subjectDAO = new SubjectDAO();

        // Read filter values
        String deptParam = request.getParameter("departmentId");
        String semParam = request.getParameter("semester");
        String subParam = request.getParameter("subjectId");
        String dateParam = request.getParameter("attendanceDate");

        int departmentId = 0;
        int semester = 0;
        int subjectId = 0;

        try {

            if (deptParam != null && !deptParam.isEmpty()) {
                departmentId = Integer.parseInt(deptParam);
            }

            if (semParam != null && !semParam.isEmpty()) {
                semester = Integer.parseInt(semParam);
            }

            if (subParam != null && !subParam.isEmpty()) {
                subjectId = Integer.parseInt(subParam);
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        // Load department dropdown
        request.setAttribute("departmentList",
                departmentDAO.getAllDepartments());

        // Load subject dropdown according to selected department/semester
        if (departmentId > 0 && semester > 0) {

            request.setAttribute("subjectList",
                    subjectDAO.getSubjectsByDepartmentSemester(departmentId, semester));

        } else if (departmentId > 0) {

            request.setAttribute("subjectList",
                    subjectDAO.getSubjectsByDepartment(departmentId));

        } else {

            request.setAttribute("subjectList",
                    subjectDAO.getAllSubjects());

        }

        // Preserve selected values
        request.setAttribute("selectedDepartment", departmentId);
        request.setAttribute("selectedSemester", semester);
        request.setAttribute("selectedSubject", subjectId);
        request.setAttribute("selectedDate", dateParam);

        // Attendance list
        if (departmentId > 0
                || semester > 0
                || subjectId > 0
                || (dateParam != null && !dateParam.isEmpty())) {

            request.setAttribute(
                    "attendanceList",
                    attendanceDAO.getFilteredAttendance(
                            departmentId,
                            semester,
                            subjectId,
                            dateParam));

        } else {

            request.setAttribute(
                    "attendanceList",
                    attendanceDAO.getAllAttendance());

        }

        request.getRequestDispatcher("/jsp/attendance-list.jsp")
                .forward(request, response);

    }

}
