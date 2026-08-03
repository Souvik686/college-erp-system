<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="model.Student"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    List<Student> students = (List<Student>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Student List</title>

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

            .action-bar{

                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:20px;

            }

            .action-bar a{

                display:inline-block;
                padding:10px 20px;
                background:#3498db;
                color:white;
                text-decoration:none;
                border-radius:6px;
                font-weight:bold;

            }

            .action-bar a:hover{

                background:#2980b9;

            }

            .search-box input[type=text]{

                padding:10px;
                width:220px;
                border:1px solid #ccc;
                border-radius:6px;

            }

            .search-box input[type=submit]{

                padding:10px 18px;
                border:none;
                background:#3498db;
                color:white;
                border-radius:6px;
                cursor:pointer;
                font-weight:bold;

            }

            .search-box input[type=submit]:hover{

                background:#2980b9;

            }

            table{

                width:100%;
                border-collapse:collapse;
                background:white;

            }

            th{

                background:#2c3e50;
                color:white;
                padding:12px;

            }

            td{

                padding:12px;
                text-align:center;
                border:1px solid #ddd;

            }

            tr:hover{

                background:#f8f9fa;

            }

            .edit{

                color:#3498db;
                text-decoration:none;
                font-weight:bold;

            }

            .edit:hover{

                text-decoration:underline;

            }

            .delete{

                color:#e74c3c;
                text-decoration:none;
                font-weight:bold;

            }

            .delete:hover{

                text-decoration:underline;

            }
            .table-card{

                background:white;
                padding:25px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

        </style>

    </head>

    <body>

        <%
            if ("added".equals(request.getParameter("success"))) {
        %>

        <script>

            alert("Student added successfully.");

            window.history.replaceState({}, document.title, window.location.pathname);

        </script>

        <%
            }
        %>

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

            <h3>Student Management</h3>

        </div>

        <div class="container">

            <div class="table-card">

                <div class="action-bar">

                    <a href="<%=request.getContextPath()%>/jsp/add-student.jsp">
                        Add New Student
                    </a>

                    <form class="search-box"
                          action="<%=request.getContextPath()%>/SearchStudentServlet"
                          method="get">

                        <input
                            type="text"
                            name="rollNo"
                            placeholder="Enter Roll Number">

                        <input
                            type="submit"
                            value="Search">

                    </form>

                </div>

                <table>

                    <tr>

                        <th>ID</th>
                        <th>Roll No</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Semester</th>
                        <th>Action</th>

                    </tr>

                    <%

                        if (students != null && !students.isEmpty()) {

                            for (Student s : students) {

                    %>

                    <tr>

                        <td><%=s.getStudentId()%></td>

                        <td><%=s.getRollNo()%></td>

                        <td><%=s.getName()%></td>

                        <td><%=s.getEmail()%></td>

                        <td><%=s.getPhone()%></td>

                        <td><%=s.getSemester()%></td>

                        <td>

                            <a class="edit"
                               href="<%=request.getContextPath()%>/jsp/edit-student.jsp?id=<%=s.getStudentId()%>">

                                Edit

                            </a>

                            |

                            <a class="delete"
                               href="<%=request.getContextPath()%>/DeleteStudentServlet?id=<%=s.getStudentId()%>"
                               onclick="return confirm('Delete Student?');">

                                Delete

                            </a>

                        </td>

                    </tr>

                    <%

                        }

                    } else {

                    %>

                    <tr>

                        <td colspan="7">

                            No Students Found

                        </td>

                    </tr>

                    <%            }

                    %>

                </table>

            </div>
        </div>

    </body>

</html>