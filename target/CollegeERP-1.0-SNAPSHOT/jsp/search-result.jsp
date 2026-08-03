<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="model.Student"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    Student s = (Student) request.getAttribute("student");
%>

<!DOCTYPE html>

<html>

    <head>

        <meta charset="UTF-8">

        <title>Search Student</title>

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

            .message{

                background:white;
                padding:40px;
                text-align:center;
                font-size:22px;
                color:#e74c3c;
                border-radius:10px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            .back{

                margin-top:25px;
                text-align:center;

            }

            .back a{

                display:inline-block;
                padding:10px 20px;
                background:#3498db;
                color:white;
                text-decoration:none;
                border-radius:6px;
                font-weight:bold;

            }

            .back a:hover{

                background:#2980b9;

            }

        </style>

    </head>

    <body>

        <div class="header">

            <div class="top-links">

                <a href="<%=request.getContextPath()%>/AdminDashboardServlet">
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

            <h3>Student Search Result</h3>

        </div>

        <div class="container">

            <%

                if (s != null) {

            %>

            <table>

                <tr>

                    <th>ID</th>
                    <th>Roll No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Semester</th>

                </tr>

                <tr>

                    <td><%=s.getStudentId()%></td>

                    <td><%=s.getRollNo()%></td>

                    <td><%=s.getName()%></td>

                    <td><%=s.getEmail()%></td>

                    <td><%=s.getPhone()%></td>

                    <td><%=s.getSemester()%></td>

                </tr>

            </table>

            <%

            } else {

            %>

            <div class="message">

                No Student Found

            </div>

            <%    }

            %>

            <div class="back">

                <a href="<%=request.getContextPath()%>/StudentListServlet">

                    Back to Student List

                </a>

            </div>

        </div>

    </body>

</html>