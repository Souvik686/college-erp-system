package model;

public class Student {

    private int studentId;
    private int userId;
    private int departmentId;

    private String rollNo;
    private String name;
    private String email;
    private String phone;

    private int semester;

    public Student() {
    }

    public Student(int studentId, int userId, int departmentId,
            String rollNo, String name,
            String email, String phone,
            int semester) {

        this.studentId = studentId;
        this.userId = userId;
        this.departmentId = departmentId;
        this.rollNo = rollNo;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.semester = semester;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public String getRollNo() {
        return rollNo;
    }

    public void setRollNo(String rollNo) {
        this.rollNo = rollNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }
}
