package dao;

import util.DBConnection;
import model.Faculty;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FacultyDAO {

    public boolean addFaculty(Faculty f) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql
                    = "INSERT INTO faculty(user_id,department_id,faculty_name,email,phone)VALUES( ?,  ?,  ?,  ?,  ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, f.getUserId());
            ps.setInt(2, f.getDepartmentId());
            ps.setString(3, f.getFacultyName());
            ps.setString(4, f.getEmail());
            ps.setString(5, f.getPhone());

            status = ps.executeUpdate() > 0;

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }

    public boolean addFaculty(Connection con, Faculty f) throws Exception {

        String sql = "INSERT INTO faculty(user_id,department_id,faculty_name,email,phone) VALUES(?,?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, f.getUserId());
        ps.setInt(2, f.getDepartmentId());
        ps.setString(3, f.getFacultyName());
        ps.setString(4, f.getEmail());
        ps.setString(5, f.getPhone());

        boolean status = ps.executeUpdate() > 0;

        ps.close();

        return status;
    }

    public List<Faculty> getAllFaculty() {

        List<Faculty> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement("SELECT * FROM faculty");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Faculty f = new Faculty();

                f.setFacultyId(rs.getInt("faculty_id"));
                f.setUserId(rs.getInt("user_id"));
                f.setDepartmentId(rs.getInt("department_id"));
                f.setFacultyName(rs.getString("faculty_name"));
                f.setEmail(rs.getString("email"));
                f.setPhone(rs.getString("phone"));

                list.add(f);

            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR: " + e.getMessage());
        }

        return list;

    }

    public int getFacultyIdByUserId(Connection con, int userId) throws Exception {

        int facultyId = 0;

        String sql = "SELECT faculty_id FROM faculty WHERE user_id=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            facultyId = rs.getInt("faculty_id");
        }

        rs.close();
        ps.close();

        return facultyId;
    }

    public int getFacultyIdByUserId(int userId) {

        int facultyId = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT faculty_id FROM faculty WHERE user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                facultyId = rs.getInt("faculty_id");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return facultyId;
    }

    public Faculty getFacultyById(int facultyId) {

        Faculty faculty = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM faculty WHERE faculty_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, facultyId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                faculty = new Faculty();

                faculty.setFacultyId(rs.getInt("faculty_id"));
                faculty.setUserId(rs.getInt("user_id"));
                faculty.setDepartmentId(rs.getInt("department_id"));
                faculty.setFacultyName(rs.getString("faculty_name"));
                faculty.setEmail(rs.getString("email"));
                faculty.setPhone(rs.getString("phone"));

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return faculty;

    }

    public boolean updateFaculty(Faculty faculty) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql
                    = "UPDATE faculty SET "
                    + "faculty_name=?, "
                    + "email=?, "
                    + "phone=? "
                    + "WHERE faculty_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, faculty.getFacultyName());
            ps.setString(2, faculty.getEmail());
            ps.setString(3, faculty.getPhone());
            ps.setInt(4, faculty.getFacultyId());

            status = ps.executeUpdate() > 0;

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }

    public int getLastFacultyId() {

        int facultyId = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT MAX(faculty_id) FROM faculty";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                facultyId = rs.getInt(1);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return facultyId;

    }

    public boolean deleteFaculty(int facultyId) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql = "DELETE FROM faculty WHERE faculty_id=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, facultyId);

        boolean status = ps.executeUpdate() > 0;

        ps.close();
        con.close();

        return status;
    }

    public int getFacultyCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM faculty";

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

    public List<Integer> getAssignedFacultyIds(int subjectId) {

        List<Integer> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT faculty_id FROM faculty_subject WHERE subject_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, subjectId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(rs.getInt("faculty_id"));

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public void updateFacultySubjects(int subjectId, String[] facultyIds) {

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM faculty_subject WHERE subject_id=?");

            ps.setInt(1, subjectId);
            ps.executeUpdate();
            ps.close();

            if (facultyIds != null) {

                String sql = "INSERT INTO faculty_subject(subject_id, faculty_id) VALUES(?,?)";

                ps = con.prepareStatement(sql);

                for (String facultyId : facultyIds) {

                    ps.setInt(1, subjectId);
                    ps.setInt(2, Integer.parseInt(facultyId));
                    ps.executeUpdate();

                }

                ps.close();

            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }
}
