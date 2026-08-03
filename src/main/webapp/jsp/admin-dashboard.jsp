<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Admin Dashboard</title>

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
                box-shadow:0 2px 8px rgba(0,0,0,0.2);
            }

            .header h1{
                margin-bottom:10px;
            }

            .header p{
                margin-bottom:10px;
                font-size:18px;
            }

            .container{

                width:1000px;
                margin:40px auto;

                display:grid;
                grid-template-columns:repeat(3,1fr);
                gap:25px;

            }

            .card{

                background:white;
                border-radius:12px;
                padding:25px;
                text-align:center;

                box-shadow:0 4px 12px rgba(0,0,0,0.15);

                transition:.3s;

            }

            .card:hover{

                transform:translateY(-5px);

            }

            .card h3{

                color:#2c3e50;
                margin-bottom:20px;

            }

            .card a{

                display:inline-block;

                padding:10px 22px;

                text-decoration:none;

                background:#3498db;

                color:white;

                border-radius:6px;

                font-weight:bold;

            }

            .card a:hover{

                background:#2980b9;

            }

        </style>

    </head>

    <body>

        <div class="header">

            <h1>College ERP System</h1>

            <p>Welcome, <b><%=user.getUsername()%></b></p>

            <h3>Administrator Dashboard</h3>

        </div>

        <div class="container">

            <div class="card">

                <h3>Student Management</h3>

                <a href="<%=request.getContextPath()%>/StudentListServlet">
                    Manage
                </a>

            </div>

            <div class="card">

                <h3>Faculty Management</h3>

                <a href="<%=request.getContextPath()%>/FacultyListServlet">
                    Manage
                </a>

            </div>

            <div class="card">

                <h3>Department Management</h3>

                <a href="<%=request.getContextPath()%>/DepartmentListServlet">
                    Manage
                </a>

            </div>

            <div class="card">

                <h3>Subject Management</h3>

                <a href="<%=request.getContextPath()%>/SubjectListServlet">
                    Manage
                </a>

            </div>

            <div class="card">

                <h3>Attendance Management</h3>

                <a href="<%=request.getContextPath()%>/AttendanceListServlet">
                    Manage
                </a>

            </div>

            <div class="card">

                <h3>Logout</h3>

                <a href="<%=request.getContextPath()%>/LogoutServlet">
                    Logout
                </a>

            </div>

        </div>

    </body>

</html>