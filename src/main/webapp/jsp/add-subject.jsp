<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>

<%@page import="model.User"%>
<%@page import="dao.DepartmentDAO"%>
<%@page import="dao.FacultyDAO"%>

<%@page import="model.Department"%>
<%@page import="model.Faculty"%>

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

        <title>Add Subject</title>

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
                font-weight:bold;
                color:#2c3e50;

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

            .button-group{

                display:flex;
                gap:15px;

            }

            .button-group input{

                flex:1;
                border:none;
                color:white;
                cursor:pointer;
                font-size:16px;
                font-weight:bold;

            }

            input[type=submit]{

                background:#3498db;

            }

            input[type=submit]:hover{

                background:#2980b9;

            }

            input[type=reset]{

                background:#7f8c8d;

            }

            input[type=reset]:hover{

                background:#636e72;

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

            <h3>Add Subject</h3>

        </div>

        <div class="container">

            <form action="<%=request.getContextPath()%>/AddSubjectServlet" method="post">

                <label>Subject Code</label>

                <input
                    type="text"
                    name="subjectCode"
                    placeholder="Enter Subject Code"
                    required>

                <label>Subject Name</label>

                <input
                    type="text"
                    name="subjectName"
                    placeholder="Enter Subject Name"
                    required>

                <label>Department</label>

                <select name="departmentId" required>

                    <option value="">Select Department</option>

                    <%
                        DepartmentDAO departmentDAO = new DepartmentDAO();
                        List<Department> departments = departmentDAO.getAllDepartments();

                        for (Department department : departments) {
                    %>

                    <option value="<%=department.getDepartmentId()%>">

                        <%=department.getDepartmentName()%>

                    </option>

                    <%
                        }
                    %>

                </select>

                <label>Semester</label>

                <select name="semester" required>

                    <option value="">Select Semester</option>

                    <%
                        for (int i = 1; i <= 8; i++) {
                    %>

                    <option value="<%=i%>">

                        Semester <%=i%>

                    </option>

                    <%
                        }
                    %>

                </select>

                <label>Faculty</label>

                <select name="facultyId" required>

                    <option value="">Select Faculty</option>

                    <%
                        FacultyDAO facultyDAO = new FacultyDAO();
                        List<Faculty> facultyList = facultyDAO.getAllFaculty();

                        for (Faculty faculty : facultyList) {
                    %>

                    <option value="<%=faculty.getFacultyId()%>">

                        <%=faculty.getFacultyName()%>

                    </option>

                    <%
                        }
                    %>

                </select>

                <div class="button-group">

                    <input
                        type="submit"
                        value="Add Subject">

                    <input
                        type="reset"
                        value="Clear">

                </div>

            </form>

        </div>

    </body>

</html>