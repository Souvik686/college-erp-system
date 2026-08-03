<%@page import="java.util.List"%>
<%@page import="model.Department"%>
<%@page import="model.User"%>

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

        <title>Department List</title>

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
                margin-bottom:10px;
                font-size:18px;
            }

            .header h3{
                margin:0;
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

                width:90%;
                max-width:1000px;
                margin:40px auto;

            }

            .add-btn{

                display:inline-block;
                padding:12px 22px;
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

            .table-card{

                background:white;
                padding:25px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

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
                border:1px solid #ddd;

            }

            tbody tr:nth-child(even){

                background:#f8f8f8;

            }

            tbody tr:hover{

                background:#eef6ff;

            }

            .edit-btn{

                background:#3498db;
                color:white;
                padding:8px 16px;
                border-radius:5px;
                text-decoration:none;

            }

            .edit-btn:hover{

                background:#2980b9;

            }

            .delete-btn{

                background:#e74c3c;
                color:white;
                padding:8px 16px;
                border-radius:5px;
                text-decoration:none;

            }

            .delete-btn:hover{

                background:#c0392b;

            }

        </style>

    </head>

    <body>

        <%
            String error = request.getParameter("error");
        %>

        <script>

            <% if ("assigned".equals(error)) { %>

            alert("Cannot delete department because it is assigned to students, faculty, or subjects.");

            <% } else if ("failed".equals(error)) { %>

            alert("Failed to delete department.");

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

            <h3>Department Management</h3>

        </div>

        <div class="container">



            <div class="table-card">
                <a class="add-btn"
                   href="<%=request.getContextPath()%>/jsp/add-department.jsp">

                    Add New Department

                </a>
                <table>

                    <thead>

                        <tr>

                            <th>Department ID</th>
                            <th>Department Name</th>
                            <th>Edit</th>
                            <th>Delete</th>

                        </tr>

                    </thead>

                    <tbody>

                        <%

                            List<Department> departmentList
                                    = (List<Department>) request.getAttribute("departmentList");

                            if (departmentList != null && !departmentList.isEmpty()) {

                                for (Department department : departmentList) {

                        %>

                        <tr>

                            <td><%=department.getDepartmentId()%></td>

                            <td><%=department.getDepartmentName()%></td>

                            <td>

                                <a class="edit-btn"
                                   href="<%=request.getContextPath()%>/EditDepartmentServlet?departmentId=<%=department.getDepartmentId()%>">

                                    Edit

                                </a>

                            </td>

                            <td>

                                <a class="delete-btn"
                                   href="<%=request.getContextPath()%>/DeleteDepartmentServlet?departmentId=<%=department.getDepartmentId()%>"
                                   onclick="return confirm('Are you sure you want to delete this department?');">

                                    Delete

                                </a>

                            </td>

                        </tr>

                        <%

                            }

                        } else {

                        %>

                        <tr>

                            <td colspan="4">

                                No Departments Found.

                            </td>

                        </tr>

                        <%                }

                        %>

                    </tbody>

                </table>

            </div>

        </div>

    </body>

</html>