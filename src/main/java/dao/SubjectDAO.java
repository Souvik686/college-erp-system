package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Subject;
import util.DBConnection;

public class SubjectDAO {

    public boolean addSubject(Subject subject) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO subjects(subject_code, subject_name, department_id, semester) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, subject.getSubjectCode());
            ps.setString(2, subject.getSubjectName());
            ps.setInt(3, subject.getDepartmentId());
            ps.setInt(4, subject.getSemester());

            int rows = ps.executeUpdate();

            if (rows > 0) {

                status = true;

            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }

    public List<Subject> getSubjectsByFaculty(int facultyId) {

        List<Subject> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql
                    = "SELECT s.* "
                    + "FROM subjects s "
                    + "INNER JOIN faculty_subject fs ON s.subject_id = fs.subject_id "
                    + "WHERE fs.faculty_id = ? "
                    + "ORDER BY s.semester, s.subject_name";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, facultyId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Subject subject = new Subject();

                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setDepartmentId(rs.getInt("department_id"));
                subject.setSemester(rs.getInt("semester"));

                list.add(subject);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }

    public List<Subject> getSubjectsByDepartment(int departmentId) {

        List<Subject> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM subjects WHERE department_id=? ORDER BY subject_name";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, departmentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Subject subject = new Subject();

                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setDepartmentId(rs.getInt("department_id"));
                subject.setSemester(rs.getInt("semester"));

                list.add(subject);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public List<Subject> getAllSubjects() {

        List<Subject> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql
                    = "SELECT s.*, "
                    + "COALESCE(GROUP_CONCAT(f.faculty_name SEPARATOR ', '), 'Not Assigned') AS faculty_names "
                    + "FROM subjects s "
                    + "LEFT JOIN faculty_subject fs ON s.subject_id = fs.subject_id "
                    + "LEFT JOIN faculty f ON fs.faculty_id = f.faculty_id "
                    + "GROUP BY s.subject_id "
                    + "ORDER BY s.subject_id";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Subject subject = new Subject();

                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setDepartmentId(rs.getInt("department_id"));
                subject.setSemester(rs.getInt("semester"));
                subject.setFacultyNames(rs.getString("faculty_names"));

                list.add(subject);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }

    public Subject getSubjectById(int subjectId) {

        Subject subject = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM subjects WHERE subject_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, subjectId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                subject = new Subject();

                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setDepartmentId(rs.getInt("department_id"));
                subject.setSemester(rs.getInt("semester"));

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return subject;

    }

    public List<Subject> getSubjectsByDepartmentSemester(int departmentId, int semester) {

        List<Subject> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql
                    = "SELECT s.*, "
                    + "COALESCE(GROUP_CONCAT(f.faculty_name SEPARATOR ', '), 'Not Assigned') AS faculty_names "
                    + "FROM subjects s "
                    + "LEFT JOIN faculty_subject fs ON s.subject_id = fs.subject_id "
                    + "LEFT JOIN faculty f ON fs.faculty_id = f.faculty_id "
                    + "WHERE s.department_id=? AND s.semester=? "
                    + "GROUP BY s.subject_id "
                    + "ORDER BY s.subject_name";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, departmentId);
            ps.setInt(2, semester);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Subject subject = new Subject();

                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setDepartmentId(rs.getInt("department_id"));
                subject.setSemester(rs.getInt("semester"));
                subject.setFacultyNames(rs.getString("faculty_names"));

                list.add(subject);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }

    public boolean updateSubject(Subject subject) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE subjects SET subject_code=?, subject_name=?, department_id=?, semester=? WHERE subject_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, subject.getSubjectCode());
            ps.setString(2, subject.getSubjectName());
            ps.setInt(3, subject.getDepartmentId());
            ps.setInt(4, subject.getSemester());
            ps.setInt(5, subject.getSubjectId());

            int rows = ps.executeUpdate();

            if (rows > 0) {

                status = true;

            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;

    }

    public Subject getSubject(int id) {

        Subject subject = null;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM subjects WHERE subject_id=?");

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                subject = new Subject();

                subject.setSubjectId(rs.getInt("subject_id"));
                subject.setSubjectCode(rs.getString("subject_code"));
                subject.setSubjectName(rs.getString("subject_name"));
                subject.setDepartmentId(rs.getInt("department_id"));
                subject.setSemester(rs.getInt("semester"));

            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return subject;

    }

    public boolean deleteSubject(int subjectId) throws Exception {

        Connection con = DBConnection.getConnection();

        String sql = "DELETE FROM subjects WHERE subject_id=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, subjectId);

        boolean status = ps.executeUpdate() > 0;

        ps.close();
        con.close();

        return status;
    }

    public int getSubjectCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM subjects";

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
