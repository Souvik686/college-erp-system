package dao;

import model.Attendance;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    public boolean addAttendance(Attendance attendance) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO attendance(student_id, faculty_id, subject_id, attendance_date, status) VALUES(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, attendance.getStudentId());
            ps.setInt(2, attendance.getFacultyId());
            ps.setInt(3, attendance.getSubjectId());
            ps.setString(4, attendance.getAttendanceDate());
            ps.setString(5, attendance.getStatus());

            status = ps.executeUpdate() > 0;

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;
    }

    public List<Attendance> getAttendanceByStudentWithDetails(int studentId) {

        List<Attendance> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql
                    = "SELECT a.*, s.subject_name, f.faculty_name "
                    + "FROM attendance a "
                    + "JOIN subjects s ON a.subject_id = s.subject_id "
                    + "JOIN faculty f ON a.faculty_id = f.faculty_id "
                    + "WHERE a.student_id=? "
                    + "ORDER BY a.attendance_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Attendance attendance = new Attendance();

                attendance.setAttendanceId(rs.getInt("attendance_id"));
                attendance.setStudentId(rs.getInt("student_id"));
                attendance.setFacultyId(rs.getInt("faculty_id"));
                attendance.setSubjectId(rs.getInt("subject_id"));

                attendance.setAttendanceDate(rs.getString("attendance_date"));
                attendance.setStatus(rs.getString("status"));

                attendance.setSubjectName(rs.getString("subject_name"));
                attendance.setFacultyName(rs.getString("faculty_name"));

                list.add(attendance);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public List<Attendance> getAllAttendance() {

        List<Attendance> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql
                    = "SELECT a.attendance_id, "
                    + "s.student_id, s.name, s.roll_no, s.semester, "
                    + "sub.subject_id, sub.subject_name, "
                    + "f.faculty_id, f.faculty_name, "
                    + "d.department_name, "
                    + "a.attendance_date, a.status "
                    + "FROM attendance a "
                    + "JOIN students s ON a.student_id = s.student_id "
                    + "JOIN subjects sub ON a.subject_id = sub.subject_id "
                    + "JOIN faculty f ON a.faculty_id = f.faculty_id "
                    + "JOIN departments d ON s.department_id = d.department_id "
                    + "ORDER BY a.attendance_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Attendance a = new Attendance();

                a.setAttendanceId(rs.getInt("attendance_id"));

                a.setStudentId(rs.getInt("student_id"));
                a.setStudentName(rs.getString("name"));
                a.setRollNo(rs.getString("roll_no"));

                a.setFacultyId(rs.getInt("faculty_id"));
                a.setFacultyName(rs.getString("faculty_name"));

                a.setSubjectId(rs.getInt("subject_id"));
                a.setSubjectName(rs.getString("subject_name"));

                a.setDepartmentName(rs.getString("department_name"));

                a.setSemester(rs.getInt("semester"));

                a.setAttendanceDate(rs.getString("attendance_date"));

                a.setStatus(rs.getString("status"));

                list.add(a);

            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }

    public List<Attendance> getAttendanceByStudent(int studentId) {

        List<Attendance> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM attendance WHERE student_id=? ORDER BY attendance_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Attendance a = new Attendance();

                a.setAttendanceId(rs.getInt("attendance_id"));
                a.setStudentId(rs.getInt("student_id"));
                a.setFacultyId(rs.getInt("faculty_id"));
                a.setSubjectId(rs.getInt("subject_id"));
                a.setAttendanceDate(rs.getString("attendance_date"));
                a.setStatus(rs.getString("status"));

                list.add(a);

            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }

    public List<Attendance> getFilteredAttendance(int departmentId,
            int semester,
            int subjectId,
            String attendanceDate) {

        List<Attendance> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            StringBuilder sql = new StringBuilder();

            sql.append("SELECT ");
            sql.append("a.attendance_id,");
            sql.append("st.student_id,");
            sql.append("st.name,");
            sql.append("st.roll_no,");
            sql.append("st.semester,");
            sql.append("a.faculty_id,");
            sql.append("a.subject_id,");
            sql.append("s.subject_name,");
            sql.append("f.faculty_name,");
            sql.append("d.department_name,");
            sql.append("a.attendance_date,");
            sql.append("a.status ");

            sql.append("FROM attendance a ");

            sql.append("JOIN students st ON a.student_id = st.student_id ");
            sql.append("JOIN subjects s ON a.subject_id = s.subject_id ");
            sql.append("JOIN faculty f ON a.faculty_id = f.faculty_id ");
            sql.append("JOIN departments d ON st.department_id = d.department_id ");

            sql.append("WHERE 1=1 ");

            if (departmentId > 0) {
                sql.append("AND st.department_id = ? ");
            }

            if (semester > 0) {
                sql.append("AND st.semester = ? ");
            }

            if (subjectId > 0) {
                sql.append("AND a.subject_id = ? ");
            }

            if (attendanceDate != null && !attendanceDate.isEmpty()) {
                sql.append("AND a.attendance_date = ? ");
            }

            if (departmentId > 0 && semester == 0) {

                sql.append(" ORDER BY ");
                sql.append("st.semester ASC, ");
                sql.append("s.subject_name ASC, ");
                sql.append("a.attendance_date DESC, ");
                sql.append("st.name ASC");

            } else if (departmentId > 0 && semester > 0 && subjectId == 0) {

                sql.append(" ORDER BY ");
                sql.append("s.subject_name ASC, ");
                sql.append("a.attendance_date DESC, ");
                sql.append("st.name ASC");

            } else if (subjectId > 0 && (attendanceDate == null || attendanceDate.isEmpty())) {

                sql.append(" ORDER BY ");
                sql.append("a.attendance_date DESC, ");
                sql.append("st.name ASC");

            } else {

                sql.append(" ORDER BY ");
                sql.append("st.name ASC");

            }
            System.out.println(sql.toString());

            PreparedStatement ps = con.prepareStatement(sql.toString());

            int index = 1;

            if (departmentId > 0) {
                ps.setInt(index++, departmentId);
            }

            if (semester > 0) {
                ps.setInt(index++, semester);
            }

            if (subjectId > 0) {
                ps.setInt(index++, subjectId);
                System.out.println("Department = " + departmentId);
                System.out.println("Semester = " + semester);
                System.out.println("Subject = " + subjectId);
                System.out.println("Date = " + attendanceDate);
            }

            if (attendanceDate != null && !attendanceDate.isEmpty()) {
                ps.setString(index++, attendanceDate);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Attendance attendance = new Attendance();

                attendance.setAttendanceId(rs.getInt("attendance_id"));
                attendance.setStudentId(rs.getInt("student_id"));
                attendance.setFacultyId(rs.getInt("faculty_id"));
                attendance.setSubjectId(rs.getInt("subject_id"));

                attendance.setAttendanceDate(rs.getString("attendance_date"));
                attendance.setStatus(rs.getString("status"));

                attendance.setStudentName(rs.getString("name"));
                attendance.setRollNo(rs.getString("roll_no"));
                attendance.setSubjectName(rs.getString("subject_name"));
                attendance.setFacultyName(rs.getString("faculty_name"));
                attendance.setDepartmentName(rs.getString("department_name"));
                attendance.setSemester(rs.getInt("semester"));

                list.add(attendance);

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public boolean deleteAttendance(int attendanceId) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM attendance WHERE attendance_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, attendanceId);

            status = ps.executeUpdate() > 0;

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;
    }
}
