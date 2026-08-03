package controller;

import dao.FacultyDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/FacultyListServlet")
public class FacultyListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        FacultyDAO dao = new FacultyDAO();

        request.setAttribute("facultyList",
                dao.getAllFaculty());

        RequestDispatcher rd
                = request.getRequestDispatcher("jsp/faculty-list.jsp");

        rd.forward(request, response);

    }

}
