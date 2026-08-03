package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

public class FacultySubjectDAO {

    public void assignSubject(int facultyId, int subjectId) {

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO faculty_subject(faculty_id, subject_id) VALUES(?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, facultyId);
            ps.setInt(2, subjectId);

            ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

    public void assignSubject(Connection con, int facultyId, int subjectId) throws Exception {

        String sql = "INSERT INTO faculty_subject(faculty_id, subject_id) VALUES(?, ?)";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, facultyId);
        ps.setInt(2, subjectId);

        ps.executeUpdate();

        ps.close();
    }

    public List<Integer> getAssignedSubjects(int facultyId) {

        List<Integer> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT subject_id FROM faculty_subject WHERE faculty_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, facultyId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(rs.getInt("subject_id"));

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public void deleteAssignments(int facultyId) {

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM faculty_subject WHERE faculty_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, facultyId);

            ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}
