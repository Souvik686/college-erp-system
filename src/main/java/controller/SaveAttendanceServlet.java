package controller;

import dao.AttendanceDAO;
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

import model.Attendance;
import model.Student;
import model.Subject;
import model.User;

@WebServlet("/SaveAttendanceServlet")
public class SaveAttendanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("user") == null) {

                response.sendRedirect(request.getContextPath() + "/");
                return;

            }

            User user = (User) session.getAttribute("user");

            FacultyDAO facultyDAO = new FacultyDAO();

            int facultyId = facultyDAO.getFacultyIdByUserId(user.getUserId());

            int subjectId = Integer.parseInt(request.getParameter("subjectId"));

            String attendanceDate = request.getParameter("attendanceDate");

            SubjectDAO subjectDAO = new SubjectDAO();

            Subject subject = subjectDAO.getSubjectById(subjectId);

            StudentDAO studentDAO = new StudentDAO();

            List<Student> students = studentDAO.getStudentsByDepartmentAndSemester(
                    subject.getDepartmentId(),
                    subject.getSemester());

            String[] presentStudents = request.getParameterValues("studentId");

            AttendanceDAO attendanceDAO = new AttendanceDAO();

            for (Student student : students) {

                Attendance attendance = new Attendance();

                attendance.setStudentId(student.getStudentId());

                attendance.setFacultyId(facultyId);

                attendance.setSubjectId(subjectId);

                attendance.setAttendanceDate(attendanceDate);

                boolean present = false;

                if (presentStudents != null) {

                    for (String id : presentStudents) {

                        if (Integer.parseInt(id) == student.getStudentId()) {

                            present = true;
                            break;

                        }

                    }

                }

                if (present) {

                    attendance.setStatus("Present");

                } else {

                    attendance.setStatus("Absent");

                }

                attendanceDAO.addAttendance(attendance);

            }

            response.sendRedirect(request.getContextPath()
                    + "/AttendanceListServlet");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/TakeAttendanceServlet");

        }

    }

}
