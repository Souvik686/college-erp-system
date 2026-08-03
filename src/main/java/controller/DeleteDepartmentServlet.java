package controller;

import dao.DepartmentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/DeleteDepartmentServlet")
public class DeleteDepartmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int departmentId = Integer.parseInt(request.getParameter("departmentId"));

            DepartmentDAO dao = new DepartmentDAO();

            boolean status = dao.deleteDepartment(departmentId);

            if (status) {

                response.sendRedirect(request.getContextPath()
                        + "/DepartmentListServlet?msg=deleted");

            } else {

                response.sendRedirect(request.getContextPath()
                        + "/DepartmentListServlet?error=failed");

            }

        } catch (SQLIntegrityConstraintViolationException e) {

            response.sendRedirect(request.getContextPath()
                    + "/DepartmentListServlet?error=assigned");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(request.getContextPath()
                    + "/DepartmentListServlet?error=failed");

        }

    }

}
