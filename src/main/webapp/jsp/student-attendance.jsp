<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="model.Attendance"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 3) {

        response.sendRedirect(request.getContextPath() + "/jsp/student-login.jsp");
        return;

    }

    List<Attendance> attendanceList
            = (List<Attendance>) request.getAttribute("attendanceList");
%>

<!DOCTYPE html>

<html>

    <head>

        <meta charset="UTF-8">

        <title>My Attendance</title>

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

            .present{

                display:inline-block;
                background:#27ae60;
                color:white;
                padding:6px 15px;
                border-radius:20px;
                font-weight:bold;

            }

            .absent{

                display:inline-block;
                background:#c0392b;
                color:white;
                padding:6px 15px;
                border-radius:20px;
                font-weight:bold;

            }

            .no-data{

                background:white;
                padding:40px;
                text-align:center;
                font-size:20px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

        </style>

    </head>

    <body>

        <div class="header">

            <div class="top-links">

                <a href="<%=request.getContextPath()%>/jsp/student-dashboard.jsp">
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

            <h3>My Attendance</h3>

        </div>

        <div class="container">

            <%

                if (attendanceList != null && !attendanceList.isEmpty()) {

            %>

            <table>

                <tr>

                    <th>Subject</th>

                    <th>Faculty</th>

                    <th>Date</th>

                    <th>Status</th>

                </tr>

                <%    for (Attendance attendance : attendanceList) {

                %>

                <tr>

                    <td><%=attendance.getSubjectName()%></td>

                    <td><%=attendance.getFacultyName()%></td>

                    <td><%=attendance.getAttendanceDate()%></td>

                    <td>

                        <% if ("Present".equalsIgnoreCase(attendance.getStatus())) { %>

                        <span class="present">

                            Present

                        </span>

                        <% } else { %>

                        <span class="absent">

                            Absent

                        </span>

                        <% } %>

                    </td>

                </tr>

                <%

                    }

                %>

            </table>

            <%} else {

            %>

            <div class="no-data">

                No attendance records found.

            </div>

            <%    }

            %>

        </div>

    </body>

</html>