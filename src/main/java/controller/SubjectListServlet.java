package controller;

import dao.SubjectDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/SubjectListServlet")
public class SubjectListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        SubjectDAO dao = new SubjectDAO();

        request.setAttribute("subjectList", dao.getAllSubjects());

        request.getRequestDispatcher("/jsp/subject-list.jsp")
                .forward(request, response);

    }
}
