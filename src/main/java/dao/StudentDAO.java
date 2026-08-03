package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Student;
import util.DBConnection;

public class StudentDAO {

    public boolean addStudent(Student student) {

        try {

            Connection con = DBConnection.getConnection();

            String sql
                    = "INSERT INTO students(user_id,department_id,roll_no,name,email,phone,semester) VALUES(?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, student.getUserId());
            ps.setInt(2, student.getDepartmentId());
            ps.setString(3, student.getRollNo());
            ps.setString(4, student.getName());
            ps.setString(5, student.getEmail());
            ps.setString(6, student.getPhone());
            ps.setInt(7, student.getSemester());

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    public Student searchStudent(String roll) {

        Student s = null;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps
                    = con.prepareStatement("SELECT * FROM students WHERE roll_no=?");

            ps.setString(1, roll);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                s = new Student();

                s.setStudentId(rs.getInt("student_id"));
                s.setDepartmentId(rs.getInt("department_id"));
                s.setRollNo(rs.getString("roll_no"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setSemester(rs.getInt("semester"));

            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return s;

    }

    public boolean updateStudent(Student s) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE students SET department_id=?, roll_no=?, name=?, email=?, phone=?, semester=? WHERE student_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, s.getDepartmentId());
            ps.setString(2, s.getRollNo());
            ps.setString(3, s.getName());
            ps.setString(4, s.getEmail());
            ps.setString(5, s.getPhone());
            ps.setInt(6, s.getSemester());
            ps.setInt(7, s.getStudentId());

            status = ps.executeUpdate() > 0;

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public Student getStudentById(int id) {

        Student s = null;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps
                    = con.prepareStatement("SELECT * FROM students WHERE student_id=?");

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                s = new Student();

                s.setStudentId(rs.getInt("student_id"));
                s.setUserId(rs.getInt("user_id"));
                s.setDepartmentId(rs.getInt("department_id"));
                s.setRollNo(rs.getString("roll_no"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setPhone(rs.getString("phone"));
                s.setSemester(rs.getInt("semester"));

            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return s;

    }

    public boolean deleteStudent(int id) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps
                    = con.prepareStatement("DELETE FROM students WHERE student_id=?");

            ps.setInt(1, id);

            status = ps.executeUpdate() > 0;

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public List<Student> getStudentsByDepartmentAndSemester(int departmentId, int semester) {

        List<Student> students = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM students WHERE department_id=? AND semester=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, departmentId);
            ps.setInt(2, semester);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setUserId(rs.getInt("user_id"));
                student.setDepartmentId(rs.getInt("department_id"));
                student.setRollNo(rs.getString("roll_no"));
                student.setName(rs.getString("name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setSemester(rs.getInt("semester"));

                students.add(student);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return students;

    }

    public List<Student> getAllStudents() {

        List<Student> students = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            System.out.println("Connected to: " + con.getCatalog());

            String sql = "SELECT * FROM students";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                System.out.println("Found student: " + rs.getString("name"));

                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setUserId(rs.getInt("user_id"));
                student.setDepartmentId(rs.getInt("department_id"));
                student.setRollNo(rs.getString("roll_no"));
                student.setName(rs.getString("name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setSemester(rs.getInt("semester"));

                students.add(student);
            }

            System.out.println("Total Students = " + students.size());

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }

    public boolean addStudent(Connection con, Student student) throws Exception {

        String sql = "INSERT INTO students(user_id,department_id,roll_no,name,email,phone,semester) VALUES(?,?,?,?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, student.getUserId());
        ps.setInt(2, student.getDepartmentId());
        ps.setString(3, student.getRollNo());
        ps.setString(4, student.getName());
        ps.setString(5, student.getEmail());
        ps.setString(6, student.getPhone());
        ps.setInt(7, student.getSemester());

        boolean status = ps.executeUpdate() > 0;

        ps.close();

        return status;
    }

    public int getStudentCount() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM students";

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

    public int getStudentIdByUserId(int userId) {

        int studentId = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT student_id FROM students WHERE user_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                studentId = rs.getInt("student_id");

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return studentId;

    }

}
