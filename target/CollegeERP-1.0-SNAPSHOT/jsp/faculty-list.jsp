<%@page import="java.util.List"%>
<%@page import="model.Faculty"%>
<%@page import="model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    List<Faculty> list = (List<Faculty>) request.getAttribute("facultyList");

    String error = request.getParameter("error");
    String success = request.getParameter("success");
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Faculty List</title>

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
                background:white;
                padding:30px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            .add-btn{

                display:inline-block;
                padding:10px 18px;
                background:#3498db;
                color:white;
                text-decoration:none;
                border-radius:6px;
                font-weight:bold;
                margin-bottom:20px;

            }

            .add-btn:hover{

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
                border:1px solid #ddd;
                text-align:center;

            }

            .action-btn{

                text-decoration:none;
                color:#3498db;
                font-weight:bold;

            }

            .action-btn:hover{

                color:#2980b9;

            }

        </style>

    </head>

    <body>

        <script>

            <% if ("added".equals(success)) { %>

            alert("Faculty added successfully.");

            window.history.replaceState({}, document.title, window.location.pathname);

            <% } else if ("assigned".equals(error)) { %>

            alert("Cannot delete faculty because they are assigned to one or more subjects.");

            <% } else if ("failed".equals(error)) { %>

            alert("Failed to delete faculty.");

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

            <h3>Faculty Management</h3>

        </div>

        <div class="container">

            <a class="add-btn"
               href="<%=request.getContextPath()%>/jsp/add-faculty.jsp">

                Add New Faculty

            </a>

            <table>

                <tr>

                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Edit</th>
                    <th>Delete</th>

                </tr>

                <%

                    if (list != null && !list.isEmpty()) {

                        for (Faculty f : list) {

                %>

                <tr>

                    <td><%=f.getFacultyId()%></td>

                    <td><%=f.getFacultyName()%></td>

                    <td><%=f.getEmail()%></td>

                    <td><%=f.getPhone()%></td>

                    <td>

                        <a class="action-btn"
                           href="<%=request.getContextPath()%>/EditFacultyServlet?facultyId=<%=f.getFacultyId()%>">

                            Edit

                        </a>

                    </td>

                    <td>

                        <a class="action-btn"
                           href="<%=request.getContextPath()%>/DeleteFacultyServlet?facultyId=<%=f.getFacultyId()%>"
                           onclick="return confirm('Are you sure you want to delete this faculty member?');">

                            Delete

                        </a>

                    </td>

                </tr>

                <% }

                } else {

                %>

                <tr>

                    <td colspan="6">

                        No Faculty Found.

                    </td>

                </tr>

                <%    }   %>

            </table>

        </div>

    </body>

</html>