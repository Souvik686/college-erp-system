<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="model.Subject"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    List<Subject> list = (List<Subject>) request.getAttribute("subjectList");
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Subject List</title>

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

            .table-card{

                background:white;
                padding:25px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

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

                width:1100px;
                margin:40px auto;

            }

            .add-btn{

                margin-bottom:20px;

            }

            .add-btn a{

                display:inline-block;
                padding:10px 20px;
                background:#3498db;
                color:white;
                text-decoration:none;
                border-radius:6px;
                font-weight:bold;

            }

            .add-btn a:hover{

                background:#2980b9;

            }

            table{

                width:100%;
                border-collapse:collapse;

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

        </style>

    </head>

    <body>

        <%
            String error = request.getParameter("error");
        %>

        <script>

            <% if ("assigned".equals(error)) { %>

            alert("Cannot delete subject because attendance or other records are linked to it.");

            <% } else if ("failed".equals(error)) { %>

            alert("Failed to delete subject.");

            <% }%>

        </script>

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

            <h3>Subject Management</h3>

        </div>

        <div class="container">
            <div class="table-card">

                <div class="add-btn">

                    <a href="<%=request.getContextPath()%>/jsp/add-subject.jsp">
                        Add Subject
                    </a>

                </div>

                <table>

                    <tr>

                        <th>ID</th>
                        <th>Code</th>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Semester</th>
                        <th>Faculty</th>
                        <th>Action</th>

                    </tr>

                    <%

                        if (list != null && !list.isEmpty()) {

                            for (Subject s : list) {

                    %>

                    <tr>

                        <td><%=s.getSubjectId()%></td>

                        <td><%=s.getSubjectCode()%></td>

                        <td><%=s.getSubjectName()%></td>

                        <td><%=s.getDepartmentId()%></td>

                        <td><%=s.getSemester()%></td>

                        <td><%=s.getFacultyNames()%></td>

                        <td>

                            <a class="edit"
                               href="<%=request.getContextPath()%>/EditSubjectServlet?id=<%=s.getSubjectId()%>">

                                Edit

                            </a>

                            |

                            <a class="delete"
                               href="<%=request.getContextPath()%>/DeleteSubjectServlet?subjectId=<%=s.getSubjectId()%>"
                               onclick="return confirm('Delete Subject?')">

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

                            No Subjects Found.

                        </td>

                    </tr>

                    <%            }

                    %>

                </table>

            </div>
        </div>

    </body>

</html>