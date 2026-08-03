<%@page import="java.util.List"%>
<%@page import="dao.DepartmentDAO"%>
<%@page import="model.Department"%>
<%@page import="model.User"%>
<%@page import="model.Student"%>
<%@page import="dao.StudentDAO"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || user.getRoleId() != 1) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin-login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    StudentDAO dao = new StudentDAO();
    Student s = dao.getStudentById(id);

    DepartmentDAO departmentDAO = new DepartmentDAO();
    List<Department> departmentList = departmentDAO.getAllDepartments();
%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">

        <title>Edit Student</title>

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
                width:auto;
                margin-bottom:0;

                background:#3498db;
                color:white;
                border:none;
                cursor:pointer;
                font-size:16px;
                font-weight:bold;

            }



            .button-group input:hover{

                background:#2980b9;

            }

            .cancel-btn{

                flex:1;
                text-align:center;
                padding:12px;
                background:#7f8c8d;
                color:white;
                text-decoration:none;
                border-radius:6px;
                font-weight:bold;

            }

            .cancel-btn:hover{

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

            <h3>Edit Student</h3>

        </div>

        <div class="container">

            <form action="<%=request.getContextPath()%>/EditStudentServlet" method="post">

                <input
                    type="hidden"
                    name="studentId"
                    value="<%=s.getStudentId()%>">

                <label>Department</label>

                <select name="departmentId" required>

                    <option value="">Select Department</option>

                    <%
                        for (Department department : departmentList) {
                    %>

                    <option
                        value="<%=department.getDepartmentId()%>"
                        <%=department.getDepartmentId() == s.getDepartmentId() ? "selected" : ""%>>

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
                    value="<%=s.getRollNo()%>"
                    required>

                <label>Student Name</label>

                <input
                    type="text"
                    name="name"
                    value="<%=s.getName()%>"
                    required>

                <label>Email</label>

                <input
                    type="email"
                    name="email"
                    value="<%=s.getEmail()%>"
                    required>

                <label>Phone Number</label>

                <input
                    type="text"
                    name="phone"
                    value="<%=s.getPhone()%>"
                    required>

                <label>Semester</label>

                <input
                    type="number"
                    name="semester"
                    value="<%=s.getSemester()%>"
                    min="1"
                    max="8"
                    required>

                <div class="button-group">

                    <input
                        type="submit"
                        value="Update Student">

                    <a class="cancel-btn"
                       href="<%=request.getContextPath()%>/StudentListServlet">

                        Cancel

                    </a>

                </div>

            </form>

        </div>

    </body>

</html>