package controller;

import dao.StudentDAO;
import model.Student;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SearchStudentServlet")
public class SearchStudentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String roll = request.getParameter("rollNo");

        StudentDAO dao = new StudentDAO();

        Student s = dao.searchStudent(roll);

        request.setAttribute("student", s);

        RequestDispatcher rd
                = request.getRequestDispatcher("jsp/search-result.jsp");

        rd.forward(request, response);

    }

}
