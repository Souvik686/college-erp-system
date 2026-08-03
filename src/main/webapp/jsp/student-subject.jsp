<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="model.Subject"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 3) {
        response.sendRedirect(request.getContextPath() + "/jsp/student-login.jsp");
        return;
    }

    List<Subject> subjectList
            = (List<Subject>) request.getAttribute("subjectList");
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>My Subjects</title>

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

            <h3>My Subjects</h3>

        </div>

        <div class="container">

            <table>

                <tr>

                    <th>Subject Code</th>
                    <th>Subject Name</th>
                    <th>Department</th>
                    <th>Semester</th>
                    <th>Faculty</th>

                </tr>

                <%

                    if (subjectList != null && !subjectList.isEmpty()) {

                        for (Subject s : subjectList) {

                %>

                <tr>

                    <td><%=s.getSubjectCode()%></td>

                    <td><%=s.getSubjectName()%></td>

                    <td><%=s.getDepartmentId()%></td>

                    <td><%=s.getSemester()%></td>

                    <td><%=s.getFacultyNames()%></td>

                </tr>

                <%

                    }

                } else {

                %>

                <tr>

                    <td colspan="5">

                        No subjects found.

                    </td>

                </tr>

                <%    }

                %>

            </table>

        </div>

    </body>

</html>