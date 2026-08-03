package model;

public class Subject {

    private int subjectId;
    private String subjectCode;
    private String subjectName;
    private int departmentId;
    private int semester;
    private String facultyNames;

    public Subject() {
    }

    public Subject(int subjectId, String subjectCode, String subjectName,
            int departmentId, int semester, int facultyId) {

        this.subjectId = subjectId;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.departmentId = departmentId;
        this.semester = semester;

    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public String getFacultyNames() {
        return facultyNames;
    }

    public void setFacultyNames(String facultyNames) {
        this.facultyNames = facultyNames;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

}
