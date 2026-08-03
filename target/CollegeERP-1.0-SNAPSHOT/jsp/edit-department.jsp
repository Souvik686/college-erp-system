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

        <title>Edit Department</title>

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

                width:500px;
                margin:40px auto;
                background:white;
                padding:30px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            label{

                display:block;
                margin-bottom:8px;
                color:#2c3e50;
                font-weight:bold;

            }

            input[type=text]{

                width:100%;
                padding:12px;
                margin-bottom:25px;
                border:1px solid #ccc;
                border-radius:6px;
                font-size:15px;

            }

            input[type=text]:focus{

                outline:none;
                border-color:#3498db;

            }

            input[type=submit]{

                width:100%;
                padding:12px;
                background:#3498db;
                color:white;
                border:none;
                border-radius:6px;
                font-size:16px;
                font-weight:bold;
                cursor:pointer;

            }

            input[type=submit]:hover{

                background:#2980b9;

            }

            .back-link{

                text-align:center;
                margin-top:25px;

            }

            .back-link a{

                color:#3498db;
                text-decoration:none;
                font-weight:bold;

            }

            .back-link a:hover{

                color:#2980b9;

            }

            .not-found{

                width:500px;
                margin:40px auto;
                background:white;
                padding:30px;
                border-radius:12px;
                text-align:center;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            .not-found h3{

                margin-bottom:20px;
                color:#e74c3c;

            }

            .not-found a{

                color:#3498db;
                text-decoration:none;
                font-weight:bold;

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

            <h3>Edit Department</h3>

        </div>

        <%

            Department department = (Department) request.getAttribute("department");

            if (department == null) {

        %>

        <div class="not-found">

            <h3>Department not found.</h3>

            <a href="<%=request.getContextPath()%>/DepartmentListServlet">
                Back to Department List
            </a>

        </div>

        <%

        } else {

        %>

        <div class="container">

            <form action="<%=request.getContextPath()%>/EditDepartmentServlet" method="post">

                <input
                    type="hidden"
                    name="departmentId"
                    value="<%=department.getDepartmentId()%>">

                <label>Department Name</label>

                <input
                    type="text"
                    name="departmentName"
                    value="<%=department.getDepartmentName()%>"
                    required>

                <input
                    type="submit"
                    value="Update Department">

            </form>

            <div class="back-link">

                <a href="<%=request.getContextPath()%>/DepartmentListServlet">
                    Back to Department List
                </a>

            </div>

        </div>

        <%

            }

        %>

    </body>

</html>