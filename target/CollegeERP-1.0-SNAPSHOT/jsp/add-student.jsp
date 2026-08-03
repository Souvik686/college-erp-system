<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="dao.DepartmentDAO" %>
<%@ page import="model.Department" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    DepartmentDAO departmentDAO = new DepartmentDAO();
    List<Department> departmentList = departmentDAO.getAllDepartments();
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Add Student</title>

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

                margin-top:0px;

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

                width:600px;
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

            input,
            select{

                width:100%;
                padding:12px;
                margin-bottom:20px;
                border:1px solid #ccc;
                border-radius:6px;
                font-size:15px;

            }

            input:focus,
            select:focus{

                outline:none;
                border-color:#3498db;

            }

            button{

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

            button:hover{

                background:#2980b9;

            }

        </style>

    </head>

    <body>

        <%
            String error = request.getParameter("error");

            if ("username".equals(error)) {
        %>

        <script>
            alert("Username already exists.");
        </script>

        <%
        } else if ("email".equals(error)) {
        %>

        <script>
            alert("Student email already exists.");
        </script>

        <%
        } else if ("roll".equals(error)) {
        %>

        <script>
            alert("Roll number already exists.");
        </script>

        <%
        } else if ("failed".equals(error)) {
        %>

        <script>
            alert("Failed to add student.");
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

            <h3>Add Student</h3>

        </div>

        <div class="container">

            <form action="<%=request.getContextPath()%>/AddStudentServlet" method="post">

                <label>Username</label>

                <input
                    type="text"
                    name="username"
                    placeholder="Enter Username"
                    required>

                <label>Password</label>

                <input
                    type="password"
                    name="password"
                    placeholder="Enter Password"
                    required>

                <label>Department</label>

                <select name="departmentId" required>

                    <option value="">Select Department</option>

                    <%
                        for (Department department : departmentList) {
                    %>

                    <option value="<%=department.getDepartmentId()%>">

                        <%=department.getDepartmentName()%>

                    </option>

                    <%
                        }
                    %>

                </select>

                <label>Roll Number</label>

                <input
                    type="text"
                    name="rollNo"
                    placeholder="Enter Roll Number"
                    required>

                <label>Student Name</label>

                <input
                    type="text"
                    name="name"
                    placeholder="Enter Student Name"
                    required>

                <label>Email</label>

                <input
                    type="email"
                    name="email"
                    placeholder="Enter Email"
                    required>

                <label>Phone Number</label>

                <input
                    type="text"
                    name="phone"
                    placeholder="Enter Phone Number"
                    required>

                <label>Semester</label>

                <input
                    type="number"
                    name="semester"
                    placeholder="Enter Semester"
                    min="1"
                    max="8"
                    required>

                <button type="submit">

                    Save Student

                </button>

            </form>

        </div>

    </body>

</html>