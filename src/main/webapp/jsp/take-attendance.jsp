<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="model.Subject"%>
<%@page import="model.Student"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 2) {
        response.sendRedirect(request.getContextPath() + "/jsp/faculty-login.jsp");
        return;
    }

    List<Subject> subjects
            = (List<Subject>) request.getAttribute("subjects");

    Subject selectedSubject
            = (Subject) request.getAttribute("selectedSubject");

    List<Student> students
            = (List<Student>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Take Attendance</title>

        <style>

            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:Arial, Helvetica, sans-serif;
            }

            body{
                background:#f4f6f9;
            }

            .header{

                background:#2c3e50;
                color:white;
                text-align:center;
                padding:25px;
                position:relative;
                box-shadow:0 2px 8px rgba(0,0,0,.2);

            }

            .header h1{
                margin-bottom:10px;
            }

            .header p{
                font-size:18px;
            }

            .header h3{
                margin-top:10px;
            }

            .top-links{

                position:absolute;
                top:25px;
                right:30px;

            }

            .top-links a{

                color:white;
                text-decoration:none;
                font-weight:bold;
                margin-left:20px;

            }

            .top-links a:hover{

                text-decoration:underline;

            }

            .container{

                width:1000px;
                margin:40px auto;

            }

            .form-box{

                background:white;
                padding:25px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);
                margin-bottom:30px;

            }

            label{

                display:block;
                margin-bottom:8px;
                font-weight:bold;
                color:#2c3e50;

            }

            select,
            input[type=date]{

                width:100%;
                padding:12px;
                border:1px solid #ccc;
                border-radius:6px;
                margin-bottom:20px;
                font-size:15px;

            }

            select:focus,
            input[type=date]:focus{

                outline:none;
                border-color:#3498db;

            }

            button,
            input[type=submit]{

                padding:12px 25px;
                background:#3498db;
                color:white;
                border:none;
                border-radius:6px;
                cursor:pointer;
                font-size:15px;
                font-weight:bold;

            }

            button:hover,
            input[type=submit]:hover{

                background:#2980b9;

            }

            table{

                width:100%;
                border-collapse:collapse;
                background:white;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            th{

                background:#2c3e50;
                color:white;
                padding:12px;

            }

            td{

                padding:12px;
                text-align:center;
                border-bottom:1px solid #ddd;

            }

            tr:hover{

                background:#f8f9fa;

            }

        </style>

    </head>

    <body>

        <div class="header">

            <div class="top-links">

                <a href="<%=request.getContextPath()%>/jsp/faculty-dashboard.jsp">
                    Dashboard
                </a>

                <a href="<%=request.getContextPath()%>/LogoutServlet">
                    Logout
                </a>

            </div>

            <h1>College ERP System</h1>

            <p>

                Welcome,
                <b><%=user.getUsername()%></b>

            </p>

            <h3>Take Attendance</h3>

        </div>

        <div class="container">

            <div class="form-box">

                <form action="<%=request.getContextPath()%>/TakeAttendanceServlet" method="get">

                    <label>Select Subject</label>

                    <select name="subjectId" required>

                        <option value="">Select Subject</option>

                        <%

                            if (subjects != null) {

                                for (Subject s : subjects) {

                        %>

                        <option value="<%=s.getSubjectId()%>"

                                <%=selectedSubject != null
                                && selectedSubject.getSubjectId() == s.getSubjectId()
                                ? "selected" : ""%>>

                            <%=s.getSubjectCode()%> - <%=s.getSubjectName()%>

                        </option>

                        <%

                                }

                            }

                        %>

                    </select>

                    <input type="submit" value="Load Students">

                </form>

            </div>

            <%    if (selectedSubject != null && students != null) {

            %>

            <div class="form-box">

                <form action="<%=request.getContextPath()%>/SaveAttendanceServlet" method="post">

                    <input
                        type="hidden"
                        name="subjectId"
                        value="<%=selectedSubject.getSubjectId()%>">

                    <label>Attendance Date</label>

                    <input
                        type="date"
                        name="attendanceDate"
                        required>

                    <table>

                        <tr>

                            <th>Roll No</th>
                            <th>Student Name</th>
                            <th>Present</th>

                        </tr>

                        <%

                            for (Student s : students) {

                        %>

                        <tr>

                            <td><%=s.getRollNo()%></td>

                            <td><%=s.getName()%></td>

                            <td>

                                <input
                                    type="checkbox"
                                    name="studentId"
                                    value="<%=s.getStudentId()%>"
                                    checked>

                            </td>

                        </tr>

                        <%

                            }

                        %>

                    </table>

                    <br>

                    <input
                        type="submit"
                        value="Save Attendance">

                </form>

            </div>

            <%    }

            %>

        </div>

    </body>

</html>