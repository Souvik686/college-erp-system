<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>

<%@page import="model.Attendance"%>
<%@page import="model.Department"%>
<%@page import="model.Subject"%>


<%
    List<Department> departmentList
            = (List<Department>) request.getAttribute("departmentList");

    List<Subject> subjectList
            = (List<Subject>) request.getAttribute("subjectList");

    Integer selectedDepartment
            = (Integer) request.getAttribute("selectedDepartment");

    Integer selectedSemester
            = (Integer) request.getAttribute("selectedSemester");

    Integer selectedSubject
            = (Integer) request.getAttribute("selectedSubject");

    String selectedDate
            = (String) request.getAttribute("selectedDate");

    if (selectedDepartment == null) {
        selectedDepartment = 0;
    }
    if (selectedSemester == null) {
        selectedSemester = 0;
    }
    if (selectedSubject == null) {
        selectedSubject = 0;
    }
    if (selectedDate == null)
        selectedDate = "";
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Attendance Management</title>

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
                padding:25px;
                text-align:center;
                box-shadow:0 2px 8px rgba(0,0,0,.2);

            }

            .header h1{

                margin-bottom:8px;

            }

            .container{

                width:95%;
                max-width:1300px;

                margin:35px auto;

            }

            .filter-box{

                background:white;

                padding:20px;

                border-radius:10px;

                box-shadow:0 4px 12px rgba(0,0,0,.15);

                margin-bottom:25px;

            }

            .filter-title{

                font-size:20px;

                color:#2c3e50;

                margin-bottom:18px;

            }

            .filters{

                display:grid;

                grid-template-columns:2fr 2fr 2fr 2fr auto;

                gap:18px;

                align-items:end;


            }

            .filters div{

                display:flex;

                flex-direction:column;

            }

            .filters label{

                font-weight:bold;

                margin-bottom:6px;

                color:#333;

            }

            .filters select,
            .filters input{

                padding:10px;

                border:1px solid #ccc;

                border-radius:6px;

            }

            .filter-btn{

                margin-top:20px;

                background:#3498db;

                color:white;

                border:none;

                padding:12px 30px;

                border-radius:6px;

                cursor:pointer;

                font-size:15px;

            }
            .reset-btn{

                display:flex;
                justify-content:center;
                align-items:center;

                height:42px;

                padding:0 22px;

                background:#7f8c8d;

                color:white;

                text-decoration:none;

                border-radius:6px;

                font-weight:bold;

                transition:.3s;

            }

            .reset-btn:hover{

                background:#636e72;

            }

            .filter-btn:hover{

                background:#2980b9;

            }

            .table-card{

                background:white;

                padding:25px;

                border-radius:10px;

                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            .table-title{

                font-size:24px;

                color:#2c3e50;

                margin-bottom:20px;

            }

            table{

                width:100%;

                border-collapse:collapse;

            }

            thead{

                background:#2c3e50;

                color:white;

            }

            th{

                padding:14px;

                text-align:center;

            }

            td{

                padding:12px;

                text-align:center;

                border-bottom:1px solid #ddd;

            }

            tbody tr:nth-child(even){

                background:#f8f8f8;

            }

            tbody tr:hover{

                background:#eef6ff;

            }

            .present{

                background:#2ecc71;

                color:white;

                padding:6px 14px;

                border-radius:20px;

                font-weight:bold;

            }

            .absent{

                background:#e74c3c;

                color:white;

                padding:6px 14px;

                border-radius:20px;

                font-weight:bold;

            }

            .delete-btn{

                background:#e74c3c;

                color:white;

                text-decoration:none;

                padding:8px 16px;

                border-radius:5px;

            }

            .delete-btn:hover{

                background:#c0392b;

            }

            .filters select{

                background:white;

            }

            .filters input{

                background:white;

            }

            .filter-btn{

                transition:.3s;

            }

            .delete-btn{

                transition:.3s;

            }

            .table-card{

                overflow-x:auto;

            }

            .table-header{

                display:flex;

                justify-content:space-between;

                align-items:center;

                margin-bottom:20px;

            }

            .record-count{

                background:#ecf0f1;

                color:#2c3e50;

                padding:8px 16px;

                border-radius:20px;

                font-weight:bold;

                font-size:14px;

            }

            @media(max-width:900px){

                .filters{

                    grid-template-columns:1fr;

                }

            }

            .top-links{

                position:absolute;
                top:30px;
                right:30px;

            }

            .top-links a{

                color:white;
                text-decoration:none;
                font-weight:bold;
                margin-left:20px;

            }
            .header h3{
                margin-top:0px;
            }
            .header p{
                margin-bottom:10px;
                font-size:18px;
            }

            .top-links a:hover{

                text-decoration:underline;

            }

        </style>

    </head>

    <body>

        <%@page import="model.User"%>

        <%
            User user = (User) session.getAttribute("user");

            if (user == null) {

                response.sendRedirect(request.getContextPath() + "/");
                return;

            }

            if (user.getRoleId() != 1 && user.getRoleId() != 2) {

                response.sendRedirect(request.getContextPath() + "/");
                return;

            }
        %>

        <div class="header">

            <div class="top-links">

                <a href="<%=request.getContextPath()%>/<%= user.getRoleId() == 1 ? "AdminDashboardServlet" : "jsp/faculty-dashboard.jsp"%>">
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

            <h3>Attendance Management</h3>

        </div>

        <div class="container">

            <div class="filter-box">

                <div class="filter-title">

                    Filter Attendance Records

                </div>

                <form action="<%=request.getContextPath()%>/AttendanceListServlet"
                      method="get">

                    <div class="filters">

                        <div>

                            <label>Department</label>

                            <select name="departmentId" onchange="this.form.submit()">

                                <option value="">All Departments</option>

                                <%
                                    for (Department d : departmentList) {
                                %>

                                <option value="<%=d.getDepartmentId()%>"
                                        <%=selectedDepartment == d.getDepartmentId() ? "selected" : ""%>>

                                    <%=d.getDepartmentName()%>

                                </option>

                                <%
                                    }
                                %>

                            </select>

                        </div>

                        <div>

                            <label>Semester</label>

                            <select name="semester" onchange="this.form.submit()">

                                <option value="">All Semesters</option>

                                <%
                                    for (int i = 1; i <= 8; i++) {
                                %>

                                <option value="<%=i%>"
                                        <%=selectedSemester == i ? "selected" : ""%>>

                                    Semester <%=i%>

                                </option>

                                <%
                                    }
                                %>

                            </select>

                        </div>

                        <div>

                            <label>Subject</label>

                            <select name="subjectId" onchange="this.form.submit()">

                                <option value="">All Subjects</option>

                                <%
                                    for (Subject s : subjectList) {
                                %>

                                <option value="<%=s.getSubjectId()%>"
                                        <%=selectedSubject == s.getSubjectId() ? "selected" : ""%>>

                                    <%=s.getSubjectName()%>

                                </option>

                                <%
                                    }
                                %>

                            </select>

                        </div>

                        <div>

                            <label>Date</label>

                            <input
                                type="date"
                                name="attendanceDate"
                                value="<%=selectedDate%>"
                                onchange="this.form.submit()">

                        </div>
                        <div>

                            <label>&nbsp;</label>

                            <a href="<%=request.getContextPath()%>/AttendanceListServlet"
                               class="reset-btn">

                                Reset

                            </a>

                        </div>

                    </div>

                </form>

            </div>

            <%
                List<Attendance> attendanceList
                        = (List<Attendance>) request.getAttribute("attendanceList");
            %>

            <div class="table-card">

                <div class="table-header">

                    <div class="table-title">

                        Attendance Records

                    </div>

                    <div class="record-count">

                        Showing
                        <%=attendanceList != null ? attendanceList.size() : 0%>
                        Record(s)

                    </div>

                </div>

                <table>

                    <thead>

                        <tr>

                            <th>Semester</th>
                            <th>Subject</th>
                            <th>Date</th>
                            <th>Student Name</th>
                            <th>Roll No</th>
                            <th>Status</th>
                            <th>Action</th>

                        </tr>

                    </thead>

                    <tbody>

                        <%
                            if (attendanceList != null && !attendanceList.isEmpty()) {

                                int count = 1;

                                for (Attendance attendance : attendanceList) {
                        %>

                        <tr>

                            <td>Semester <%=attendance.getSemester()%></td>

                            <td><%=attendance.getSubjectName()%></td>

                            <td><%=attendance.getAttendanceDate()%></td>

                            <td><%=attendance.getStudentName()%></td>

                            <td><%=attendance.getRollNo()%></td>

                            <td>

                                <% if ("Present".equalsIgnoreCase(attendance.getStatus())) { %>

                                <span class="present">
                                    Present
                                </span>

                                <% } else { %>

                                <span class="absent">
                                    Absent
                                </span>

                                <% }%>

                            </td>

                            <td>

                                <a class="delete-btn"
                                   href="<%=request.getContextPath()%>/DeleteAttendanceServlet?attendanceId=<%=attendance.getAttendanceId()%>"
                                   onclick="return confirm('Are you sure you want to permanently delete this attendance record?\n\nThis action cannot be undone.');">

                                    Delete

                                </a>

                            </td>

                        </tr>

                        <%
                            }

                        } else {
                        %>

                        <tr>

                            <td colspan="7"
                                style="padding:30px;
                                text-align:center;
                                font-weight:bold;
                                color:#777;">

                                No attendance records found.

                            </td>

                        </tr>

                        <%
                            }
                        %>

                    </tbody>

                </table>

            </div>

        </div>

    </body>

</html>