package controller;

import dao.StudentDAO;
import model.Student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/EditStudentServlet")
public class EditStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Student s = new Student();

        s.setStudentId(Integer.parseInt(request.getParameter("studentId")));
        s.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));
        s.setRollNo(request.getParameter("rollNo"));
        s.setName(request.getParameter("name"));
        s.setEmail(request.getParameter("email"));
        s.setPhone(request.getParameter("phone"));
        s.setSemester(Integer.parseInt(request.getParameter("semester")));

        StudentDAO dao = new StudentDAO();

        dao.updateStudent(s);

        response.sendRedirect("StudentListServlet");

    }

}
