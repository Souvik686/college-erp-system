package controller;

import dao.DepartmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Department;

@WebServlet("/AddDepartmentServlet")
public class AddDepartmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {
            
            String departmentName = request.getParameter("departmentName");

            Department department = new Department();

            department.setDepartmentName(departmentName);

            DepartmentDAO departmentDAO = new DepartmentDAO();

            boolean status = departmentDAO.addDepartment(department);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/DepartmentListServlet");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/jsp/add-department.jsp?error=failed");

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/jsp/add-department.jsp?error=exception");

        }

    }

}
