package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Department;
import util.DBConnection;

public class DepartmentDAO {

    public boolean addDepartment(Department department) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO departments (department_name) VALUES (?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, department.getDepartmentName());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public List<Department> getAllDepartments() {

        List<Department> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM departments ORDER BY department_id";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Department department = new Department();

                department.setDepartmentId(rs.getInt("department_id"));
                department.setDepartmentName(rs.getString("department_name"));

                list.add(department);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Department getDepartmentById(int departmentId) {

        Department department = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM departments WHERE department_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, departmentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                department = new Department();

                department.setDepartmentId(rs.getInt("department_id"));
                department.setDepartmentName(rs.getString("department_name"));
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return department;
    }

    public boolean updateDepartment(Department department) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE departments SET department_name=? WHERE department_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, department.getDepartmentName());
            ps.setInt(2, department.getDepartmentId());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public boolean deleteDepartment(int departmentId) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql = "DELETE FROM departments WHERE department_id=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, departmentId);

        boolean status = ps.executeUpdate() > 0;

        ps.close();
        con.close();

        return status;
    }

    public int getDepartmentCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM departments";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return count;
    }

}
