package controller;

import dao.DepartmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Department;

@WebServlet("/EditDepartmentServlet")
public class EditDepartmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int departmentId = Integer.parseInt(
                    request.getParameter("departmentId"));

            DepartmentDAO departmentDAO = new DepartmentDAO();

            Department department
                    = departmentDAO.getDepartmentById(departmentId);

            request.setAttribute("department", department);

            request.getRequestDispatcher("/jsp/edit-department.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/DepartmentListServlet");

        }

    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Department department = new Department();

            department.setDepartmentId(
                    Integer.parseInt(request.getParameter("departmentId")));

            department.setDepartmentName(
                    request.getParameter("departmentName"));

            DepartmentDAO departmentDAO = new DepartmentDAO();

            boolean status = departmentDAO.updateDepartment(department);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/DepartmentListServlet");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/EditDepartmentServlet?departmentId="
                        + department.getDepartmentId());

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/DepartmentListServlet");

        }

    }

}
