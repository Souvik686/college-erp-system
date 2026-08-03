package controller;

import dao.DepartmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Department;

@WebServlet("/DepartmentListServlet")
public class DepartmentListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            DepartmentDAO departmentDAO = new DepartmentDAO();

            List<Department> departmentList = departmentDAO.getAllDepartments();

            request.setAttribute("departmentList", departmentList);

            request.getRequestDispatcher("/jsp/department-list.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/jsp/admin-dashboard.jsp");

        }

    }

}
