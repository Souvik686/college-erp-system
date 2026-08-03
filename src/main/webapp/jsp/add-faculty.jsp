<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>

<%@ page import="dao.DepartmentDAO" %>
<%@ page import="dao.SubjectDAO" %>

<%@ page import="model.Department" %>
<%@ page import="model.Subject" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    DepartmentDAO departmentDAO = new DepartmentDAO();
    List<Department> departmentList = departmentDAO.getAllDepartments();

    SubjectDAO subjectDAO = new SubjectDAO();
    List<Subject> subjectList = subjectDAO.getAllSubjects();
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Add Faculty</title>

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

                width:700px;
                margin:40px auto;
                background:white;
                padding:30px;
                border-radius:12px;
                box-shadow:0 4px 12px rgba(0,0,0,.15);

            }

            label{

                display:block;
                margin-bottom:8px;
                font-weight:bold;
                color:#2c3e50;

            }

            input[type=text],
            input[type=password],
            input[type=email],
            select{

                width:100%;
                padding:12px;
                border:1px solid #ccc;
                border-radius:6px;
                font-size:15px;
                margin-bottom:20px;

            }

            input:focus,
            select:focus{

                outline:none;
                border-color:#3498db;

            }

            .subject-box{

                border:1px solid #ddd;
                border-radius:8px;
                padding:15px;
                max-height:250px;
                overflow-y:auto;
                margin-bottom:25px;

            }

            .subject-box label{

                display:block;
                margin-bottom:12px;
                font-weight:normal;
                cursor:pointer;

            }

            .subject-box input{

                margin-right:8px;

            }

            input[type=submit]{

                width:100%;
                padding:12px;
                border:none;
                border-radius:6px;
                background:#3498db;
                color:white;
                font-size:16px;
                font-weight:bold;
                cursor:pointer;

            }

            input[type=submit]:hover{

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
            alert("Faculty email already exists.");
        </script>

        <%
        } else if ("failed".equals(error)) {
        %>

        <script>
            alert("Failed to add faculty.");
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

            <h3>Add Faculty</h3>

        </div>

        <div class="container">

            <form action="<%=request.getContextPath()%>/AddFacultyServlet" method="post">

                <label>Username</label>

                <input
                    type="text"
                    name="username"
                    required>

                <label>Password</label>

                <input
                    type="password"
                    name="password"
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

                <label>Faculty Name</label>

                <input
                    type="text"
                    name="facultyName"
                    required>

                <label>Email</label>

                <input
                    type="email"
                    name="email"
                    required>

                <label>Phone</label>

                <input
                    type="text"
                    name="phone"
                    required>

                <label>Assign Subjects</label>

                <div class="subject-box">

                    <%
                        for (Subject subject : subjectList) {
                    %>

                    <label>

                        <input
                            type="checkbox"
                            name="subjectIds"
                            value="<%=subject.getSubjectId()%>">

                        <%=subject.getSubjectCode()%> - <%=subject.getSubjectName()%>

                    </label>

                    <%
                        }
                    %>

                </div>

                <input
                    type="submit"
                    value="Save Faculty">

            </form>

        </div>

    </body>

</html>